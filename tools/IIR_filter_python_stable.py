import argparse
import sys

import numpy as np
from scipy.signal import butter, freqz
from scipy.signal import zpk2sos, sosfilt 
from scipy.signal import sosfreqz
import matplotlib.pyplot as plt
parser = argparse.ArgumentParser(
    description="Generate Butterworth IIR coefficients for the C filter loader."
)
parser.add_argument("--order", type=int, default=4, help="filter order")
parser.add_argument("--cutoff", type=float, default=500, help="cutoff frequency (Hz)")
parser.add_argument("--fs", type=float, default=25.6e3, help="sample rate (Hz)")
parser.add_argument("--plot", action="store_true", help="show magnitude/phase response")
parser.add_argument("--plotfilt", action="store_true", help="apply and plot filter output")
args = parser.parse_args()

#the option below returns numerator and denominator coefficients for the direct form implementation of the filter
#num, den = butter(args.order, args.cutoff, btype="low", analog=False, output="ba", fs=args.fs)
# Coefficients go to stdout so this can be piped straight into IIR_filter_coeffs.txt.
# Everything else goes to stderr to keep that stream clean.
# print("num")
# for c in num:
#     print(f"{c:.8e}")
# print("den")
# for c in den:
#     print(f"{c:.8e}")

#the option below returns coefficients for the biquad implementation of the filter
z,p,k = butter(args.order, args.cutoff, btype="low", analog=False, output="zpk", fs=args.fs)
b,a = butter(args.order, args.cutoff, btype="low", analog=False, output="ba", fs=args.fs)
sos  = zpk2sos(z,p,1, pairing="nearest")
#Distribute the real gain 'k' evenly across both sections
num_sections = sos.shape[0]
gain_per_section = k ** (1.0 / num_sections)

# Multiply the numerator coefficients (b0, b1, b2) of each section by the split gain
sos[:, :3] *= gain_per_section

print("Balanced SOS Matrix:\n", sos)

with open("tools/filter_coefficients/biquad_coeffs.txt", "w") as f:
    f.write("num\n")
    for biquad in sos:
        for i in range(3):
            f.write(f"{biquad[i]:.8e}\n")
    f.write("den\n")
    for biquad in sos:
        for i in range(3, 6):
            f.write(f"{biquad[i]:.8e}\n")

INPUT_FILENAME = "tools/test_data/data_normalized.csv" 

# Load input samples (one value per line)
input_data = np.loadtxt(INPUT_FILENAME)

# Run the filter
filtered_data = sosfilt(sos, input_data)

if args.plot:

    z, p, k = butter(args.order, args.cutoff, btype="low",analog=False, output="zpk", fs=args.fs)
    print(f"z={z}, p={p} k={k}", file=sys.stderr)
    print(f"max pole magnitude {np.max(np.abs(p)):.6f}", file=sys.stderr)
    w, h = sosfreqz(sos, worN=512, fs=args.fs)
    plt.figure()
    plt.subplot(121)
    plt.plot(w, np.abs(h))
    plt.xlabel("Angular Frequency")
    plt.ylabel("Magnitude")
    plt.subplot(122)
    plt.plot(w, np.angle(h, deg=True))
    plt.xlabel("Angular Frequency")
    plt.ylabel("Phase (degrees)")
    plt.tight_layout()
    plt.show()

if args.plotfilt:
    plt.figure()
    plt.plot(input_data, label="Input")
    plt.plot(filtered_data, label="Filtered")
    plt.xlabel("Sample")
    plt.ylabel("Amplitude")
    plt.legend()
    plt.tight_layout()
    plt.show()