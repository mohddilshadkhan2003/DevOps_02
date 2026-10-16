#!/usr/bin/env bash
# helper: build and push to ghcr
set -euo pipefail
IMAGE=ghcr.io/${GITHUB_REPOSITORY_OWNER}/autonetops-backend:latest

echo "Building $IMAGE"
docker build -t $IMAGE autonetops-devops/docker

echo "Pushing $IMAGE"
docker push $IMAGE
