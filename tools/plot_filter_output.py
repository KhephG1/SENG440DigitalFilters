"""Convert fixed-point filter output back to float and plot it.

The C filter writes one signed integer per line (the Q-format fixed-point
sample). This script reads that file, rescales by 2^-SF to recover the float
value, and plots amplitude vs. time. Optionally overlays the raw input.

Usage:
    python tools/plot_filter_output.py test_output/filte_output.txt
    python tools/plot_filter_output.py test_output/filte_output.txt --sf 12 --fs 25600
    python tools/plot_filter_output.py test_output/filte_output.txt --input tools/data.csv
"""

import argparse

import matplotlib.pyplot as plt
import numpy as np

# Scale factors used by the C code (see coefficient_loader.c / input_data_loader.c)
OUTPUT_SF = 12  # IIR output is Q12
INPUT_SF = 6    # accelerometer input is Q6 (data.csv is already float, so unused for it)
FS = 25600      # sampling rate in Hz (matches IIR_filter.py)


INT16_MIN = -32768
INT16_MAX = 32767


def load_fixed_point(path, scale_factor):
    """Read one integer per line; return (float samples, raw int samples)."""
    raw = np.loadtxt(path)
    return raw / float(1 << scale_factor), raw


def main():
    parser = argparse.ArgumentParser(description=__doc__,
                                     formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("output_file", help="filter output file (one int per line)")
    parser.add_argument("--sf", type=int, default=OUTPUT_SF,
                        help=f"output scale factor, value >> is 2^SF (default {OUTPUT_SF})")
    parser.add_argument("--fs", type=float, default=FS,
                        help=f"sampling rate in Hz (default {FS})")
    parser.add_argument("--input", metavar="CSV",
                        help="optional raw input file to overlay (float, one per line)")
    parser.add_argument("--save", metavar="PNG",
                        help="save the plot to a file instead of showing it")
    args = parser.parse_args()

    y, y_raw = load_fixed_point(args.output_file, args.sf)
    t = np.arange(len(y)) / args.fs

    plt.figure(figsize=(10, 5))

    if args.input:
        x = np.loadtxt(args.input)
        n = min(len(x), len(y))  # loader may drop samples that overflow the buffer
        plt.plot(t[:n], x[:n], color="0.7", linewidth=0.8, label="input")

    plt.plot(t, y, "b", linewidth=0.8, label="filter output")

    saturated = int(np.sum((y_raw <= INT16_MIN) | (y_raw >= INT16_MAX)))
    title = f"Filter output ({len(y)} samples, Q{args.sf}, fs={args.fs:g} Hz)"
    if saturated:
        title += f"  —  WARNING: {saturated} samples at int16 rail (clipping)"

    plt.title(title)
    plt.xlabel("Time (s)")
    plt.ylabel("Amplitude")
    plt.grid(True)
    plt.legend()
    plt.tight_layout()

    if args.save:
        plt.savefig(args.save, dpi=120)
        print(f"saved plot to {args.save}")
    else:
        plt.show()


if __name__ == "__main__":
    main()
