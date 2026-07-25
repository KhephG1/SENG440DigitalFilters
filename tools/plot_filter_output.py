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

    # 1. Load data and convert to milliseconds
    y, y_raw = load_fixed_point(args.output_file, args.sf)
    t_ms = (np.arange(len(y)) / args.fs) * 1000.0

    # 2. Slice the arrays to strictly keep the first 100 ms of data
    time_mask = t_ms <= 100000.0
    t_ms_window = t_ms[time_mask]
    y_window = y[time_mask]
    y_raw_window = y_raw[time_mask]

    # --- Setup a 2-Row Plot Configuration ---
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(11, 7), sharex=False)

    # ==========================================
    # SUBPLOT 1: TIME DOMAIN WAVEFORM (0 to 100 ms)
    # ==========================================
    if args.input:
        x = np.loadtxt(args.input)
        x_window = x[:len(y)][time_mask] # Slice matching input window
        ax1.plot(t_ms_window, x_window, color="0.7", linewidth=0.8, label="input")

    ax1.plot(t_ms_window, y_window, "b", linewidth=0.8, label="filter output")
    
    saturated = int(np.sum((y_raw_window <= INT16_MIN) | (y_raw_window >= INT16_MAX)))
    title = f"Filter Output Time Domain (First 100 ms, {len(y_window)} samples)"
    if saturated:
        title += f"  —  WARNING: {saturated} windowed samples at int16 rail"

    ax1.set_title(title)
    ax1.set_xlabel("Time (ms)")
    ax1.set_ylabel("Amplitude")
    ax1.set_xlim(0, 10000.0) # Hard-lock viewing frame to 0-100 ms
    ax1.grid(True)
    ax1.legend()

    # ==========================================
    # SUBPLOT 2: FOURIER TRANSFORM (OF THE 100 ms WINDOW)
    # ==========================================
    n_samples = len(y_window)
    
    # Calculate Fast Fourier Transform ONLY for the visible 100ms window
    fft_output = np.fft.rfft(y_window)
    frequencies = np.fft.rfftfreq(n_samples, d=1.0/args.fs)
    
    magnitudes = (np.abs(fft_output) / n_samples) * 2.0
    if len(magnitudes) > 0:
        magnitudes[0] /= 2.0  

    # Plot the frequency magnitude spectrum
    ax2.plot(frequencies, magnitudes, "r", linewidth=1.0, label="FFT Spectrum")
    
    ax2.set_title(f"Frequency Spectrum (Fourier Transform of First 100 ms)")
    ax2.set_xlabel("Frequency (Hz)")
    ax2.set_ylabel("Magnitude")
    ax2.grid(True)
    ax2.set_xlim(0, args.fs / 2) 
    
    plt.tight_layout()

    if args.save:
        plt.savefig(args.save, dpi=120)
        print(f"saved plot to {args.save}")
    else:
        plt.show()

if __name__ == "__main__":
    main()
