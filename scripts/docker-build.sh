#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME=projeto-android-ci:latest

echo "Building Docker image ${IMAGE_NAME}..."
docker build -t ${IMAGE_NAME} .

echo "Running container to build the project (mounting current directory)..."
docker run --rm -v "$(pwd)":/workspace -w /workspace ${IMAGE_NAME}

echo "Container run completed. Check output above for build results."
