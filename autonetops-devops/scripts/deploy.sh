#!/usr/bin/env bash
set -euo pipefail

# Simple deploy helper: updates image of deployment and rolls out
IMAGE=${1:-ghcr.io/${GITHUB_REPOSITORY_OWNER:-your-org}/autonetops-backend:latest}

echo "Updating deployment image to $IMAGE"
kubectl set image deployment/autonetops-backend backend=$IMAGE --record
kubectl rollout status deployment/autonetops-backend
