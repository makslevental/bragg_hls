import math
from dataclasses import dataclass
from enum import Enum
from functools import reduce
from typing import Tuple, Any

import numpy as np

from bragghls.compiler import state
from bragghls.compiler.state import CONSTANT
from bragghls.config import DTYPE, MUL_LATENCY, ADD_LATENCY
from bragghls.util import extend_idx, chunks, is_val


def overload_op(type):
    def f(*args: "Tuple[Val]"):
        return create_new_op(type, args)

    return f


class OpType(Enum):
    ADD = "fadd"
    SUB = "fsub"
    MUL = "fmul"
    DIV = "fdiv"
    GT = "fcmpugt"
    NEG = "fneg"
    RELU = "frelu"
    CST = "arith.constant"
    COPY = "copy"
    FMAC = "fmac"


OPS = {op.value: op for op in OpType}


@dataclass(frozen=True)
class Val:
    name: str = ""
    id: str = None

    def __post_init__(self):
        state.state.incr_var()
        if self.id is None:
            object.__setattr__(self, "id", str(state.state.curr_var_id))

    __add__ = overload_op(OpType.ADD)
    __sub__ = overload_op(OpType.SUB)
    __mul__ = overload_op(OpType.MUL)
    __truediv__ = overload_op(OpType.DIV)
    __gt__ = overload_op(OpType.GT)
    __neg__ = overload_op(OpType.NEG)
    copy = overload_op(OpType.COPY)
    relu = overload_op(OpType.RELU)

    def __repr__(self):
        return f"{state.state.val_prefix}val_{self.id}"


@dataclass(frozen=True)
class Op:
    type: OpType
    pe_idx: Tuple[int, ...]
    op_id: int
    args: Tuple[Any, ...]
    res: str
    overload: str = None
    attrs: dict = None

    def __post_init__(self):
        if state.state is not None:
            object.__setattr__(self, "op_id", state.state.curr_op_id)
            state.state.incr_op_id()

    def _make_args_attrs(self):
        args_str = ", ".join(map(str, self.args))
        attrs = {
            "pe": self.pe_idx,
            "opr": self.type.value
            if self.overload is None
            else f"{self.type.value}.{self.overload}",
            "op_id": self.op_id,
        }
        if self.attrs:
            attrs.update(self.attrs)
        attrs_str = ", ".join([f'{n} = "{v}"' for n, v in attrs.items()])
        return args_str, attrs_str

    def __repr__(self):
        args_str, attrs_str = self._make_args_attrs()
        return f"{self.type.value}({args_str}) {{{attrs_str}}}"

    def emit(self):
        args_str, attrs_str = self._make_args_attrs()
        if self.type == OpType.CST:
            return f'{self.res} = "{self.type.value}" () {{  {attrs_str}, value = {self.args[0]} : {DTYPE}  }} : () -> {DTYPE}'
        else:
            return f'{self.res} = "{self.type.value}" ({args_str}) {{  {attrs_str}  }} : ({", ".join([DTYPE] * len(self.args))}) -> {DTYPE}'


FMAC_LATENCY = lambda n_elements: MUL_LATENCY + ADD_LATENCY * n_elements


class Latencies:
    latencies = {
        OpType.ADD: ADD_LATENCY,
        OpType.SUB: ADD_LATENCY,
        OpType.MUL: MUL_LATENCY,
        OpType.DIV: 3,
        OpType.GT: 1,
        OpType.NEG: 1,
        OpType.RELU: 1,
        OpType.CST: 0,
        OpType.COPY: 1,
        OpType.FMAC: -1,
    }
    fmacs = set()

    def __getitem__(self, op: Op):
        if op.type == OpType.FMAC:
            return FMAC_LATENCY((len(op.args) - 1) // 2)
        else:
            return self.latencies[op.type]

    def add(self, op):
        assert (
            isinstance(op, tuple)
            and len(op) == 2
            and op[0] == OpType.FMAC
            and isinstance(op[1], int)
        )
        self.fmacs.add(op[1])

    def items(self):
        return tuple(
            list(self.latencies.items())
            + [(f"fmac.{n_args}", FMAC_LATENCY(n_args // 2)) for n_args in self.fmacs]
        )


LATENCIES = Latencies()

CONSTANTS = set()


def make_constant(arg):
    assert isinstance(arg, (float, bool, int)), arg
    arg = str(arg)
    cst_v = Val(id=f'cst_{arg.replace(".", "")}')
    if cst_v not in CONSTANTS:
        cst_op = Op(
            OpType.CST,
            pe_idx=(-1,),
            op_id=state.state.curr_op_id,
            args=(arg,),
            res=str(cst_v),
        )
        state.state.val_source[cst_v] = CONSTANT
        state.state.emit(cst_op.emit())
        CONSTANTS.add(cst_v)
    # TODO
    # state.state.add_op_res(cst_v, cst_op)
    # state.state.add_edge(cst_op, "CONSTANT", cst_v)
    return cst_v


def create_new_op(
    op_type: OpType, args, *, pe_idx=None, res=None, add_aux_dep=False, op_overload=None
):
    if pe_idx is None:
        pe_idx = state.state.pe_idx
    if res is None:
        res = Val()

    args = list(args)
    for i, arg in enumerate(args):
        if not isinstance(arg, Val):
            assert isinstance(arg, (float, bool, int)), arg
            args[i] = make_constant(arg)

    op = Op(
        op_type,
        pe_idx=pe_idx,
        op_id=state.state.curr_op_id,
        args=tuple(args),
        res=res,
        overload=op_overload,
    )

    for arg in args:
        if "cst" in arg.id:
            continue
        state.state.add_edge(op, arg, op.res)

    state.state.emit(op.emit())

    if add_aux_dep:
        state.state.maybe_add_aux_dep(pe_idx, op)

    state.state.maybe_add_op(op)
    state.state.map_val_to_pe(res, pe_idx)
    state.state.add_op_res(res, op)

    return res


class FMAC:
    def __init__(self, *pe_idx):
        assert pe_idx
        pe_idx = extend_idx(pe_idx)
        self.pe_idx = pe_idx
        state.state.debug_print(f"MAC {pe_idx} starts")
        self.mul_vals = []
        self.add_vals = []

    def Add(self, a, b):
        self.add_vals.extend((a, b))
        return Val(f"FMAC_ADD_{self.pe_idx}({a}, {b})")

    def Mul(self, a, b):
        self.mul_vals.extend((a, b))
        return Val(f"FMAC_MUL_{self.pe_idx}({a}, {b})")

    def Result(self, copy=True):
        init_val = [v for v in self.add_vals if "FMAC" not in v.name]
        assert len(init_val) == 1
        args = init_val + self.mul_vals
        op_res = FMACOp(len(args), self.pe_idx)(*args)
        if copy:
            op_res = op_res.copy()
        state.state.debug_print(f"MAC {self.pe_idx} ends")
        return op_res


def reducer(accum, val):
    # hack because simulator ops come through here too
    if isinstance(val[0], Val):
        state.state.update_current_pe_idx(val=val[0])
    return accum + [val[0] + val[1]]


def reduce_perfect_tree(vals):
    log_len = math.log2(len(vals))
    assert log_len == int(log_len), f"len {len(vals)} of {vals} is not a power of 2"
    initial_val = []

    pairs = list(chunks(list(vals), 2))
    while len(pairs) > 1:
        pairs = list(chunks(reduce(reducer, pairs, initial_val), 2))

    if isinstance(pairs[0][0], Val):
        state.state.update_current_pe_idx(val=pairs[0][0])
    return pairs[0][0] + pairs[0][1]


ALREADY_COPIED = set()


def recursive_sum(vals):
    if len(vals) == 1:
        return vals[0]

    perfect_tree_n = 2 ** math.floor(math.log2(len(vals)))
    perfect_tree, vals = vals[:perfect_tree_n], vals[perfect_tree_n:]
    state.state.debug_print(f"// start perfect tree {perfect_tree}")
    perfect_sum = reduce_perfect_tree(perfect_tree)
    state.state.debug_print(f"// end perfect tree")
    if len(perfect_tree) == len(vals):
        return perfect_sum + reduce_perfect_tree(vals)
    elif len(vals):
        assert perfect_tree_n > len(vals)
        smaller_sum = recursive_sum(vals)
        if (
            isinstance(smaller_sum, Val)
            and smaller_sum not in ALREADY_COPIED
            and is_val(smaller_sum)
        ):
            ALREADY_COPIED.add(smaller_sum)
            smaller_sum = smaller_sum.copy()
        if (
            isinstance(perfect_sum, Val)
            and perfect_sum not in ALREADY_COPIED
            and is_val(perfect_sum)
        ):
            ALREADY_COPIED.add(perfect_sum)
            perfect_sum = perfect_sum.copy()
        return perfect_sum + smaller_sum
    else:
        return perfect_sum


def ReduceAdd(vals):
    return recursive_sum(vals)


def Copy(dst, src):
    assert dst.registers.shape == src.registers.shape
    for idx, val in np.ndenumerate(src.registers):
        if isinstance(val, Val):
            state.state.update_current_pe_idx(val=val)
        dst.registers[idx] = val.copy()


def ReduceTiling(fmac_arr, init_arr):
    assert (
        fmac_arr.registers.shape[1:] == init_arr.registers.shape[1:]
    ), f"{fmac_arr.arr_name} fmac_arr {fmac_arr.registers.shape} and {init_arr.arr_name} init_arr {init_arr.registers.shape} shape don't match"
    fmac_arr.registers = np.vstack([fmac_arr.registers, init_arr.registers])
    fmac_arr.registers = np.apply_along_axis(ReduceAdd, 0, fmac_arr.registers)[
        np.newaxis
    ]
    SelfCopy(fmac_arr)


def SelfCopy(memref):
    Copy(memref, memref)


def FMACOp(n_args, pe_idx):
    non_init_args = n_args - 1
    LATENCIES.add((OpType.FMAC, non_init_args))

    def f(*args: "Tuple[Val]"):
        return create_new_op(
            OpType.FMAC,
            args,
            pe_idx=pe_idx,
            add_aux_dep=True,
            op_overload=f"{non_init_args}",
        )

    return f
