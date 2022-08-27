#!/usr/bin/env python3
import sys

from convert_flopoco import convert_flopoco_binary_str_to_float


def main():
    fh_in = sys.stdin
    fh_out = sys.stdout

    width_exponent = width_fraction = 4
    while True:
        # incoming values have newline
        l = fh_in.readline()
        if not l:
            return 0

        # outgoing filtered values must have a newline

        try:
            print(
                f"do you have the right width_exponent width_fraction {width_exponent} {width_fraction}",
                file=sys.stderr,
            )
            s = convert_flopoco_binary_str_to_float(
                l.strip(), width_exponent, width_fraction
            )
            fh_out.write("%s\n" % s)
        except Exception as e:
            # print(e, file=sys.stderr)
            fh_out.write("%s\n" % l)
        fh_out.flush()


if __name__ == "__main__":
    sys.exit(main())
