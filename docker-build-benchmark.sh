#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Docker Build Benchmark Script
# Tests Docker build performance and caching efficiency
# Author: Taufiq
# ============================================================

# Config
IMAGE_NAME="benchmark:test"
DOCKERFILE_PATH=".docker/Dockerfile.benchmark"
BUILD_ITERATIONS=${BUILD_ITERATIONS:-3}
RESULT_DIR="./results"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RESULT_FILE="${RESULT_DIR}/docker-build-${TIMESTAMP}.log"

# Prepare result directory
mkdir -p "$RESULT_DIR"

echo "=== Docker Build Benchmark Started ==="
echo "Image: $IMAGE_NAME"
echo "Dockerfile: $DOCKERFILE_PATH"
echo "Iterations: $BUILD_ITERATIONS"
echo "Output: $RESULT_FILE"

# Benchmark loop
for i in $(seq 1 $BUILD_ITERATIONS); do
  echo "" | tee -a "$RESULT_FILE"
  echo "[$(date '+%H:%M:%S')] Run #$i" | tee -a "$RESULT_FILE"

  START=$(date +%s.%N)
  docker build --no-cache --progress=plain -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" . 2>&1 | tee -a "$RESULT_FILE"
  END=$(date +%s.%N)

  DURATION=$(awk "BEGIN {print $END - $START}")
  echo "[Run #$i] Build duration: ${DURATION}s" | tee -a "$RESULT_FILE"

  # Optional: clean cache between builds (uncomment to disable caching)
  # docker builder prune -af > /dev/null
done

# Record image size
SIZE=$(docker image inspect "$IMAGE_NAME" --format='{{.Size}}')
HUMAN_SIZE=$(numfmt --to=iec --suffix=B $SIZE)
echo "" | tee -a "$RESULT_FILE"
echo "Final image size: $HUMAN_SIZE" | tee -a "$RESULT_FILE"

echo "=== Benchmark Completed ==="
echo "Results saved to: $RESULT_FILE"
echo "Build times: $DURATION seconds per iteration"
echo "Build durations recorded for $BUILD_ITERATIONS iterations."

