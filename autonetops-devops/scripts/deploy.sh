#!/usr/bin/env bash
set -euo pipefail

IMAGE="${1:-${IMAGE_TAG:-ghcr.io/${GITHUB_REPOSITORY_OWNER:-your-org}/autonetops-backend:latest}}"
NAMESPACE="${NAMESPACE:-default}"
TIMEOUT="${TIMEOUT:-180s}"

if kubectl get deployment autonetops-backend -n "${NAMESPACE}" >/dev/null 2>&1; then
  echo "Updating deployment image to ${IMAGE}"
  kubectl set image deployment/autonetops-backend backend="${IMAGE}" --record -n "${NAMESPACE}"
  kubectl rollout status deployment/autonetops-backend -n "${NAMESPACE}" --timeout="${TIMEOUT}"
else
  echo "Deployment autonetops-backend not found in namespace ${NAMESPACE}; skipping rollout."
  echo "Use: kubectl apply -f autonetops-devops/k8s/"
fi
