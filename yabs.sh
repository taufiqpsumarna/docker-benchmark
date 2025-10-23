#!/usr/bin/env bash
set -euo pipefail

# =====================================================
# Run YABS (Yet Another Benchmark Script)
# Output saved to ./result/yabs-YYYYMMDD_HHMMSS.txt
# Author: Taufiq
# =====================================================

# Create result directory
RESULT_DIR="./result"
mkdir -p "$RESULT_DIR"

# Generate timestamped filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RESULT_FILE="${RESULT_DIR}/yabs-${TIMESTAMP}.txt"

echo "=== Running YABS Benchmark ==="
echo "Results will be saved to: $RESULT_FILE"
echo "This may take several minutes..."

# Run YABS and save both stdout and stderr to the result file
curl -sL https://yabs.sh | bash | tee "$RESULT_FILE"

echo "=== Benchmark Completed ==="
echo "Results saved in: $RESULT_FILE"

