# AutoNetOps — DevOps assets

Autonetops-devops is a standalone DevOps project extracted from a demo application. It contains container images, Kubernetes manifests, and example Terraform to get you started.

Quickstart

Prereqs: docker, docker-compose, kubectl (for k8s), terraform (optional)

Run locally:

  make build
  make run

Terraform (example):

  make tf-init
  make tf-plan

CI/CD

- CI validates and builds images on push/PR
- publish workflow pushes image to ghcr.io on main

Secrets

- GitHub Actions: GITHUB_TOKEN is used for GHCR. For Docker Hub, add DOCKERHUB_USERNAME/DOCKERHUB_TOKEN to repository secrets.
