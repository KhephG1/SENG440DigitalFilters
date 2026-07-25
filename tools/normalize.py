import pandas as pd

# Input/output files
INPUT_FILE = "data.csv"
OUTPUT_FILE = "data_normalized.csv"

# Read the CSV
df = pd.read_csv(INPUT_FILE, header=None)

# Get the single column
column = df.columns[0]

# Find the largest absolute value
max_abs = df[column].abs().max()

# Normalize
if max_abs != 0:
    df[column] = df[column] / max_abs
else:
    df[column] = 0.0  # All values are zero

# Save the normalized data
df.to_csv(OUTPUT_FILE, index=False)

print(f"Normalized data written to '{OUTPUT_FILE}'")