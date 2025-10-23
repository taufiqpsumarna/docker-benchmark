#!/usr/bin/env bash
set -euo pipefail

# =====================================================
# Docker Compose Benchmark Script (No Cache)
# Author: Taufiq
# =====================================================

SERVICE_NAME="benchmark"
IMAGE_NAME="benchmark:test"

echo "=== Stopping and removing existing containers ==="
docker-compose down

echo "=== Building image without cache ==="
docker-compose build --no-cache --pull $SERVICE_NAME

echo "=== Starting container in detached mode ==="
docker-compose up -d $SERVICE_NAME

echo "=== Following container logs ==="
docker-compose logs -f $SERVICE_NAME
