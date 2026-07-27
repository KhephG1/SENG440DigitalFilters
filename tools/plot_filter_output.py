import argparse

import matplotlib.pyplot as plt
import numpy as np

# Scale factors used by the C code
OUTPUT_SF = 7  # IIR output is Q15
FS = 25600     # sampling rate in Hz
INT16_MIN = -32768
INT16_MAX = 32767


def load_fixed_point(path, scale_factor):
    """Read one integer per line; return (float samples, raw int samples)."""
    raw = np.loadtxt(path)
    return raw / float(1 << scale_factor), raw


def plot_time(ax, t_ms, samples, color, label, title, duration_ms):
    ax.plot(t_ms, samples, color=color, linewidth=0.8, label=label)
    ax.set_title(title)
    ax.set_xlabel("Time (ms)")
    ax.set_ylabel("Amplitude")
    ax.set_xlim(0, duration_ms)
    ax.grid(True)
    ax.legend(loc="upper right")


def plot_fft(ax, samples, fs, color, label, title):
    n = len(samples)
    fft_output = np.fft.rfft(samples)
    frequencies = np.fft.rfftfreq(n, d=1.0 / fs)
    magnitudes = (np.abs(fft_output) / n) * 2.0
    if len(magnitudes) > 0:
        magnitudes[0] /= 2.0  # DC bin is not doubled
    ax.plot(frequencies, magnitudes, color=color, linewidth=1.0, label=label)
    ax.set_title(title)
    ax.set_xlabel("Frequency (Hz)")
    ax.set_ylabel("Magnitude")
    ax.set_xlim(0, fs / 2)
    ax.grid(True)
    ax.legend(loc="upper right")


def main():
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("output_file",
                        help="filter output file (one int per line)")
    parser.add_argument("--sf", type=int, default=OUTPUT_SF,
                        help=f"output scale factor, value >> is 2^SF "
                             f"(default {OUTPUT_SF})")
    parser.add_argument("--fs", type=float, default=FS,
                        help=f"sampling rate in Hz (default {FS})")
    parser.add_argument("--input", metavar="CSV",
                        help="raw input file to plot in the top row "
                             "(float, one per line)")
    parser.add_argument("--save", metavar="PNG",
                        help="save the plot to a file instead of showing it")
    args = parser.parse_args()

    # 1. Load output data and build a time axis in milliseconds
    y, y_raw = load_fixed_point(args.output_file, args.sf)
    t_ms = (np.arange(len(y)) / args.fs) * 1000.0
    duration_ms = t_ms[-1] if len(t_ms) else 0.0

    # --- 2x2 quadrant layout ---
    # Row 1: input  (time domain | FFT)
    # Row 2: output (time domain | FFT)
    fig, axes = plt.subplots(2, 2, figsize=(13, 8))
    (ax_in_t, ax_in_f), (ax_out_t, ax_out_f) = axes

    # ==========================================
    # TOP ROW: INPUT (time domain + FFT)
    # ==========================================
    if args.input:
        x = np.loadtxt(args.input)[:len(y)]  # match output length
        plot_time(ax_in_t, t_ms[:len(x)], x, "0.4", "input",
                  f"Input Time Domain ({len(x)} samples)",
                  duration_ms)
        plot_fft(ax_in_f, x, args.fs, "0.4", "input spectrum",
                 "Input Spectrum (FFT of full signal)")
    else:
        for ax in (ax_in_t, ax_in_f):
            ax.text(0.5, 0.5, "no --input file provided",
                    ha="center", va="center", transform=ax.transAxes,
                    color="0.5")
            ax.set_xticks([])
            ax.set_yticks([])

    # ==========================================
    # BOTTOM ROW: OUTPUT (time domain + FFT)
    # ==========================================
    saturated = int(np.sum((y_raw <= INT16_MIN) | (y_raw >= INT16_MAX)))
    out_title = f"Filter Output Time Domain ({len(y)} samples)"
    if saturated:
        out_title += f"\nWARNING: {saturated} samples at int16 rail"
    plot_time(ax_out_t, t_ms, y, "b", "filter output", out_title,
              duration_ms)
    plot_fft(ax_out_f, y, args.fs, "r", "output spectrum",
             "Output Spectrum (FFT of full signal)")

    plt.tight_layout()
    if args.save:
        plt.savefig(args.save, dpi=120)
        print(f"saved plot to {args.save}")
    else:
        plt.show()


if __name__ == "__main__":
    main()