import re
import enum
from textwrap import dedent

signal_width = 12
tdm_wires = 200

class CombOrSeq(enum.Enum):
    COMB = "*"
    SEQPOS = "posedge clk"
    SEQNEG = "negedge clk"

comb_or_seq = CombOrSeq.SEQPOS

part_1 = open("part_1/braggnn_part_1.sv").read()
part_2 = open("part_2/braggnn_part_2.sv").read()
part_3 = open("part_3/braggnn_part_3.sv").read()

part_1_inputs = [v.strip().replace(",", "") for v in
                 re.findall(fr"input wire \[{signal_width - 1}:0\] (.*);", part_1, re.MULTILINE)]
part_1_outputs = [v.strip().replace(",", "") for v in
                  re.findall(fr"output wire \[{signal_width - 1}:0\] (.*);", part_1, re.MULTILINE)]

part_2_inputs = [v.strip().replace(",", "") for v in
                 re.findall(fr"input wire \[{signal_width - 1}:0\] (.*);", part_2, re.MULTILINE)]
part_2_outputs = [v.strip().replace(",", "") for v in
                  re.findall(fr"output wire \[{signal_width - 1}:0\] (.*);", part_2, re.MULTILINE)]

part_3_inputs = [v.strip().replace(",", "") for v in
                 re.findall(fr"input wire \[{signal_width - 1}:0\] (.*);", part_3, re.MULTILINE)]
part_3_outputs = [v.strip().replace(",", "") for v in
                  re.findall(fr"output wire \[{signal_width - 1}:0\] (.*);", part_3, re.MULTILINE)]

top = open("top.sv", "w")

top.write(
    dedent(
        """\
        `default_nettype none
        module braggnn (
        input wire clk,
        input wire rst,\n"""
    )
)

for part_1_input in part_1_inputs:
    top.write(f"input wire [{signal_width - 1}:0] {part_1_input},\n")
for part_3_output in part_3_outputs[:-1]:
    top.write(f"output wire [{signal_width - 1}:0] {part_3_output},\n")
top.write(f"output wire [{signal_width - 1}:0] {part_3_outputs[-1]}\n")
top.write(");\n")

top.write("\n")

for part_1_output in part_1_outputs:
    top.write(f"wire [{signal_width - 1}:0] part_1_{part_1_output};\n")
for part_1_output in part_1_outputs:
    top.write(f"(* USER_SLL_REG=\"true\", shreg_extract=\"no\" *) reg [{signal_width - 1}:0] part_1_launch_{part_1_output};\n")
for part_1_output in part_1_outputs:
    top.write(f"(* USER_SLL_REG=\"true\", shreg_extract=\"no\" *) reg [{signal_width - 1}:0] part_1_land_{part_1_output};\n")

top.write("\n")

top.write(
    dedent(
        """\
        braggnn_part_1 part_1 (
        clk,
        rst,\n"""
    )
)
for part_1_input in part_1_inputs:
    top.write(f"{part_1_input},\n")
for part_1_output in part_1_outputs[:-1]:
    top.write(f"part_1_{part_1_output},\n")
top.write(f"part_1_{part_1_outputs[-1]}\n")
top.write(");\n")

# mux in

top.write("\n")

# for part_1_output in part_1_outputs[-tdm_wires:]:
#     top.write(f"wire [{signal_width - 1}:0] part_1_land_{part_1_output}_wire;\n")

top.write(f"always @ ({comb_or_seq.value}) begin\n")
for part_1_output in part_1_outputs:
    top.write(f"part_1_launch_{part_1_output} {'=' if comb_or_seq == CombOrSeq.COMB else '<='} part_1_{part_1_output};\n")
top.write("end\n")

top.write(f"always @ ({comb_or_seq.value}) begin\n")
for part_1_output in part_1_outputs[:-tdm_wires]:
    top.write(f"part_1_land_{part_1_output} {'=' if comb_or_seq == CombOrSeq.COMB else '<='} part_1_launch_{part_1_output};\n")
top.write("end\n")

# top.write(f"always @ ({comb_or_seq.value}) begin\n")
# for part_1_output in part_1_outputs[-tdm_wires:]:
#     top.write(f"part_1_land_{part_1_output} {'=' if comb_or_seq == CombOrSeq.COMB else '<='} part_1_land_{part_1_output}_wire;\n")
# top.write("end\n")
#
# launch_regs = [f"part_1_launch_{part_1_output}" for part_1_output in part_1_outputs[-tdm_wires:]]
# land_wires = [f"part_1_land_{part_1_output}_wire" for part_1_output in part_1_outputs[-tdm_wires:]]
#
# top.write(f"""\
# wire out;
# counter#(1) counter_(
#     .clk(clk),
#     .rst(rst),
#     .out(out)
# );
# mux_to_demux_2#({(len(part_1_outputs[-tdm_wires:]) // 2) * signal_width}) uut(
#     .inp({{{','.join(launch_regs)}}}),
#     .sel(out),
#     .outp({{{','.join(land_wires)}}})
# );
# """)
#
# top.write("\n")


for part_2_output in part_2_outputs:
    top.write(f"wire [{signal_width - 1}:0] part_2_{part_2_output};\n")
for part_2_output in part_2_outputs:
    top.write(f"(* USER_SLL_REG=\"true\", shreg_extract=\"no\" *) reg [{signal_width - 1}:0] part_2_launch_{part_2_output};\n")
for part_2_output in part_2_outputs:
    top.write(f"(* USER_SLL_REG=\"true\", shreg_extract=\"no\" *) reg [{signal_width - 1}:0] part_2_land_{part_2_output};\n")

top.write("\n")

top.write(
    dedent(
        """\
        braggnn_part_2 part_2 (
        clk,
        rst,\n"""
    )
)

for part_1_output in part_1_outputs:
    top.write(f"part_1_land_{part_1_output},\n")
for part_2_output in part_2_outputs[:-1]:
    top.write(f"part_2_{part_2_output},\n")
top.write(f"part_2_{part_2_outputs[-1]}\n")
top.write(");\n")

top.write("\n")

top.write(f"always @ ({comb_or_seq.value}) begin\n")
for part_2_output in part_2_outputs:
    top.write(f"part_2_launch_{part_2_output} {'=' if comb_or_seq == CombOrSeq.COMB else '<='} part_2_{part_2_output};\n")
top.write("end\n")

top.write("\n")

top.write(f"always @ ({comb_or_seq.value}) begin\n")
for part_2_output in part_2_outputs:
    top.write(f"part_2_land_{part_2_output} {'=' if comb_or_seq == CombOrSeq.COMB else '<='} part_2_launch_{part_2_output};\n")
top.write("end\n")

top.write("\n")

top.write(
    dedent(
        """\
        braggnn_part_3 part_3 (
        clk,
        rst,\n"""
    )
)

for part_2_output in part_2_outputs:
    top.write(f"part_2_land_{part_2_output},\n")
for part_3_output in part_3_outputs[:-1]:
    top.write(f"{part_3_output},\n")
top.write(f"{part_3_outputs[-1]}\n")
top.write(");\n")

top.write("endmodule")

# for i in range(1, 4):
#     top.write("\n")
#     blackbox = open(f"part_{i}/braggnn_part_{i}_blackbox.sv").read()
#     top.write(blackbox)
#     top.write("\n")


clock = open("clock.xdc", "w")
clock.write(
    "create_clock -name clk -period 10 -waveform {0.000 5} [get_ports clk]\n"
)

# set_input_delay -clock [get_clocks clk] 0 [get_ports X]
# set_input_delay -clock [get_clocks clk] 0 [get_ports Y]
# set_output_delay -clock [get_clocks clk] 0 [get_ports R]

for input in part_1_inputs:
    clock.write(f"set_input_delay -clock [get_clocks clk] 0 [get_ports {input}]\n")

for output in part_3_outputs:
    clock.write(f"set_output_delay -clock [get_clocks clk] 0 [get_ports {output}]\n")
