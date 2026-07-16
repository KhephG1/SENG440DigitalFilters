import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import freqz

b = [0.00001424, 0.00005696, 0.00008544, 0.00005696, 0.00001424]
a = [1.1624, -4.3198, 5.9975, -3.682, 0.84016]

# normalize so the y[n] coefficient (a[0]) is 1
b = [c / a[0] for c in b]
a = [c / a[0] for c in a]

fs = 25600  # Sampling rate in Hz (Change this to your actual rate)


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


write_coeffs("IIR_filter_coeffs.txt", b, a)

# Compute response using the fs parameter
w, h = freqz(b, a, worN=1024, fs=fs)

# for the purposes of implementing as biquad, need to factor
import sympy as sp
import numpy as np
from numpy.polynomial.polynomial import polyroots

z = sp.symbols("z")
# Create polynomials (z^4 + ... form)
num_poly = sum(c * z ** (4 - i) for i, c in enumerate(b))
den_poly = sum(c * z ** (4 - i) for i, c in enumerate(a))

# numpy.polyroots expects highest power first
num_roots_np = polyroots(b[::-1])  # reverse because b is low-to-high
den_roots_np = polyroots(a[::-1])

print("NumPy Numerator roots (zeros):")
for r in num_roots_np:
    print(r)

print("\nNumPy Denominator roots (poles):")
for r in den_roots_np:
    print(r)


def build_factored_np(roots, leading_coeff):
    factored = leading_coeff
    for r in roots:
        factored *= z - r
    return factored


num_factored = build_factored_np(num_roots_np, b[0])
den_factored = build_factored_np(den_roots_np, a[0])

print("\nFactored Numerator:")
sp.pprint(num_factored)
print("\nFactored Denominator:")
sp.pprint(den_factored)


# Plot Magnitude
plt.figure(figsize=(10, 6))
plt.subplot(2, 1, 1)
plt.plot(w, 20 * np.log10(abs(h)), "b")
plt.title("Digital Filter Frequency Response")
plt.ylabel("Magnitude (dB)")
plt.grid(True)

# Plot Phase
plt.subplot(2, 1, 2)
plt.plot(w, np.angle(h), "g")
plt.xlabel("Frequency (Hz)")
plt.ylabel("Phase (radians)")
plt.grid(True)
plt.show()
