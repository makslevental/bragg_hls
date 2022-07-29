import argparse
from pathlib import Path

import torch
from torch import nn

from bragghls.nn import compile_nn_module_to_mlir


class Linear(nn.Module):
    def __init__(self, imgsz):
        super().__init__()
        self.linear1 = torch.nn.Linear(imgsz, imgsz)

    def forward(self, x, y):
        return self.linear1(x).sum()


class Dot(nn.Module):
    def __init__(self):
        super().__init__()

    def forward(self, x, y):
        return (x * y).sum()


def make_dot(size=11):
    with torch.no_grad():
        mod = Dot()
        mod.eval()
        y = torch.randn(size)
        x = torch.randn(size)
        # z = mod(x, y)
    mlir_module = compile_nn_module_to_mlir(
        mod,
        [
            ([size], torch.float32),
            ([size], torch.float32),
        ],
    )
    return str(mlir_module)


def make_linear(size=11):
    with torch.no_grad():
        mod = Linear(size)
        mod.eval()
        y = torch.randn(size)
        x = torch.randn(size)
        z = mod(x, y)
    mlir_module = compile_nn_module_to_mlir(
        mod,
        [
            ([1, size], torch.float32),
            ([1, size], torch.float32),
        ],
    )
    return str(mlir_module)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="make stuff")
    parser.add_argument("--out_dir", type=Path, default=Path("."))
    parser.add_argument("--size", type=int, default=4)
    args = parser.parse_args()
    args.out_dir = args.out_dir.resolve()
    dot_str = make_linear(args.size)
    open(f"{args.out_dir}/linear.mlir", "w").write(dot_str)
