#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="${IMAGE_NAME:-ghcr.io/${GITHUB_REPOSITORY_OWNER:-${GITHUB_ACTOR:-local}}/autonetops-backend}"
IMAGE_TAG="${IMAGE_TAG:-$(git -C "$(dirname "$0")/.." rev-parse --short HEAD 2>/dev/null || echo latest)}"

echo "Building ${IMAGE_NAME}:${IMAGE_TAG}"
docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" -t "${IMAGE_NAME}:latest" autonetops-devops/docker

echo "Pushing ${IMAGE_NAME}:${IMAGE_TAG} and ${IMAGE_NAME}:latest"
docker push "${IMAGE_NAME}:${IMAGE_TAG}"
docker push "${IMAGE_NAME}:latest"
