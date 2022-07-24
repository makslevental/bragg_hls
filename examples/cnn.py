import argparse
from pathlib import Path

from torch import nn
import torch

from bragghls.nn import set_weights, compile_nn_module_to_mlir


class DoubleCNN(nn.Module):
    def __init__(self, scale):
        super().__init__()
        self.conv1 = torch.nn.Conv2d(1, 16 * scale, 3)
        self.conv2_1 = torch.nn.Conv2d(16 * scale, 8 * scale, 1)
        self.conv2_2 = torch.nn.Conv2d(16 * scale, 8 * scale, 1)
        self.conv2_3 = torch.nn.Conv2d(16 * scale, 8 * scale, 1)
        self.conv3 = torch.nn.Conv2d(8 * scale, 16 * scale, 1)
        self.conv4 = torch.nn.Conv2d(16 * scale, 8 * scale, 3)

    def forward(self, x):
        y = self.conv1(x)
        z = self.conv2_1(y)
        w = self.conv2_2(y)
        u = self.conv2_3(y)
        uuu = z + w + u
        uu = self.conv3(uuu * uuu.sum())
        ww = self.conv4(uu)
        return ww


class ConvPlusReLU(nn.Module):
    def __init__(self, in_channels, out_channels):
        super().__init__()
        self.conv1 = torch.nn.Conv2d(in_channels, out_channels, 3)
        self.conv2 = torch.nn.Conv2d(out_channels, in_channels, 3)
        self.relu = torch.nn.ReLU()

    def forward(self, x):
        return self.relu(self.conv2(self.conv1(x)))


def make_single_small_cnn(
    in_channels=2, out_channels=4, img_size=11, simplify_weights=False
):
    with torch.no_grad():
        mod = ConvPlusReLU(in_channels, out_channels)
        mod.eval()
        t = torch.randn((1, in_channels, img_size, img_size))
        y = mod(t)
        if simplify_weights:
            mod.apply(set_weights)

    mlir_module = compile_nn_module_to_mlir(
        mod,
        [
            ([1, in_channels, img_size, img_size], torch.float32),
        ],
    )
    return str(mlir_module)


def make_double_small_cnn(scale=1, img_size=11, simplify_weights=False):
    with torch.no_grad():
        mod = DoubleCNN(scale)
        mod.eval()
        t = torch.randn((1, 1, img_size, img_size))
        y = mod(t)
        if simplify_weights:
            mod.apply(set_weights)

    mlir_module = compile_nn_module_to_mlir(
        mod,
        [
            ([1, 1, img_size, img_size], torch.float32),
        ],
    )
    return str(mlir_module)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="make stuff")
    parser.add_argument("--out_dir", type=Path, default=Path("."))
    parser.add_argument("--size", type=int, default=11)
    args = parser.parse_args()
    args.out_dir = args.out_dir.resolve()

    dot_str = make_single_small_cnn(args.size, simplify_weights=True)
    open(f"{args.out_dir}/small_cnn.mlir", "w").write(dot_str)