from scipy import signal
import matplotlib.pyplot as plt
import numpy as np

taps = 51
cutoff = 500
fs = 25.6e3

filt = signal.firwin(
    taps, cutoff, width=None, window="blackman", pass_zero=True, scale=True, fs=fs
)

num = filt
den = 1


def write_coeffs(filename, num, den):
    num = np.atleast_1d(np.asarray(num, dtype=float))
    den = np.atleast_1d(np.asarray(den, dtype=float))
    with open(filename, "w") as f:
        f.write("num\n")
        for c in num:
            f.write(f"{c:.8e}\n")
        f.write("den\n")
        for c in den:
            f.write(f"{c:.8e}\n")


write_coeffs("FIR_filter_coeffs.txt", num, den)

w, h = signal.freqz(num, den, worN=2000, fs=fs)
magnitude_db = 20 * np.log10(np.abs(h))
phase_deg = np.unwrap(np.angle(h))
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(8, 6), sharex=True)

ax1.plot(w, magnitude_db, color="blue", linewidth=2)
ax1.axvline(cutoff, color="red", linestyle="--", label=f"Cutoff ({cutoff} Hz)")
ax1.set_ylabel("Magnitude (dB)")
ax1.set_title("Bode Plot of FIR Low-Pass Filter")
ax1.grid(True, which="both", color="gray", alpha=0.5)
ax1.legend()

ax2.plot(w, phase_deg, color="orange", linewidth=2)
ax2.axvline(cutoff, color="red", linestyle="--")
ax2.set_xlabel("Frequency (Hz)")
ax2.set_ylabel("Phase (Degrees)")
ax2.grid(True, which="both", color="gray", alpha=0.5)
print(filt)
plt.tight_layout()
plt.show()
