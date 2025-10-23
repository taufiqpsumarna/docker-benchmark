#!/usr/bin/env bash
set -euo pipefail

# ==========================================================
# Docker Engine v28.5.1 installation using get.docker.com
# Installs Docker Engine + CLI + Compose plugin
# Author: Taufiq
# ==========================================================

DOCKER_VERSION="28.5.1"
DOCKER_CHANNEL="stable"

echo "=== Installing Docker Engine version ${DOCKER_VERSION} ==="

# 1. Download and run official Docker convenience script
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh --version $DOCKER_VERSION --channel $DOCKER_CHANNEL

# 2. Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# 3. Add current user to docker group (for non-root usage)
if ! groups $USER | grep -q docker; then
  sudo usermod -aG docker $USER
  echo "Added $USER to the docker group. You may need to re-login."
fi

# 4. Verify installation
echo "=== Docker Version Check ==="
docker --version || echo "Run 'newgrp docker' or re-login to use docker without sudo"
docker compose version || echo "Docker Compose plugin not detected."

echo "=== Installation completed successfully ==="

