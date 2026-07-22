import argparse
import sys

import numpy as np
from scipy.signal import butter, freqz

parser = argparse.ArgumentParser(
    description="Generate Butterworth IIR coefficients for the C filter loader."
)
parser.add_argument("--order", type=int, default=4, help="filter order")
parser.add_argument("--cutoff", type=float, default=500, help="cutoff frequency (Hz)")
parser.add_argument("--fs", type=float, default=25.6e3, help="sample rate (Hz)")
parser.add_argument("--plot", action="store_true", help="show magnitude/phase response")
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
sos = butter(args.order, args.cutoff, btype="low", analog=False, output="sos", fs=args.fs)

with open("tools/biquad1.txt", "w") as f1, open("tools/biquad2.txt", "w") as f2:
    files = [f1, f2]
    for biquad, f in zip(sos, files):
        f.write("num\n")
        for i in range(3):
            f.write(f"{biquad[i]:.8e}\n")
        f.write("den\n")
        for i in range(4, 6):
            f.write(f"{-biquad[i]:.8e}\n")
# z, p, k = butter(args.order, args.cutoff, btype="low",analog=False, output="zpk", fs=args.fs)
# print(f"z={z}, p={p} k={k}", file=sys.stderr)
# print(f"max pole magnitude {np.max(np.abs(p)):.6f}", file=sys.stderr)

if args.plot:
    import matplotlib.pyplot as plt

    w, h = freqz(num, den, worN=512, fs=args.fs)
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
