# Hello, I'm Dilshad Khan 👋

Welcome! I'm a passionate developer and DevOps engineer focused on building scalable systems, automating infrastructure, and delivering reliable CI/CD pipelines.

---

## 🚀 Quick Profile

- 🔧 Specialization: DevOps, Infrastructure as Code, CI/CD Pipelines
- 💡 Passion: Building reliable systems and optimizing workflows
- 📚 Learning: Always exploring new tools and technologies
- 🌱 Growth: Committed to continuous improvement and knowledge sharing

---

## 💻 Tech Stack

![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![YAML](https://img.shields.io/badge/YAML-CB171E?style=flat-square&logo=yaml&logoColor=white)

![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=flat-square&logo=amazon-aws&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=flat-square&logo=terraform&logoColor=white)

---

## 🎯 Featured Project

### autonetops-devops — DevOps Starter Kit
A self-contained DevOps starter project extracted from an AutoNetOps demo application. It provides practical examples for containerization, local development, Kubernetes deployment, and Terraform provisioning.

Location: ./autonetops-devops

---

## AutoNetOps — DevOps Starter Kit (Detailed)

**DevOps starter project for AutoNetOps — containerization, Kubernetes manifests, and Terraform examples to bootstrap deployments and CI/CD.**

[![CI](https://img.shields.io/badge/CI-GitHub_Actions-blue)](https://github.com/mohddilshadkhan2003/DevOps_02/actions)
[![Image](https://img.shields.io/badge/Image-GHCR-orange)](https://ghcr.io)
[![License](https://img.shields.io/badge/License-MIT-green)](./autonetops-devops/LICENSE)

---

## Overview

AutoNetOps-DevOps is a self-contained DevOps starter kit extracted from an AutoNetOps demo application. It provides practical, production-minded examples for packaging an application as a container, running it locally with docker-compose, deploying to Kubernetes, and provisioning cloud infrastructure with Terraform. The repository is intentionally opinionated to help teams bootstrap infrastructure and CI/CD pipelines quickly.

This project is structured to be copy-paste friendly, well-documented, and ready to adapt to your cloud and CI preferences.

---

## Repository contents (autonetops-devops)

- `autonetops-devops/docker/` — Dockerfile and `docker-compose.yml` for local development and image build
- `autonetops-devops/k8s/` — Kubernetes manifests (Deployment, Service) for cluster deployment
- `autonetops-devops/terraform/` — Example Terraform configuration (S3 state placeholder) to provision minimal cloud resources
- `autonetops-devops/.github/workflows/` — GitHub Actions workflows (CI and image publish to GHCR)
- `autonetops-devops/Makefile` — Common tasks: build, run, tf-init, tf-plan, k8s-apply
- `autonetops-devops/scripts/` — Helper scripts for deploy and publish
- `autonetops-devops/README.md` — project-level README (also summarized here)

---

## Architecture & Workflow (summary)

```mermaid
flowchart LR
  src[Source Code]
  src -->|build| docker[Docker Build]
  docker --> registry[Image Registry\n(GHCR/DockerHub)]
  registry --> k8s[Kubernetes Cluster]
  k8s --> users[Users / Clients]
  terraform[Terraform]
  terraform --> infra[Cloud Infra (S3, ECR, VPC...)]
  ci[GitHub Actions CI/CD]
  ci -->|on push/PR| docker
  ci -->|on main| registry
  ci -->|deploy| k8s
  infra --> k8s
```

Workflow explanation:

- Developers push code and/or infrastructure changes to a feature branch and open a Pull Request.
- CI workflow runs linting, tests, and builds a Docker image (for PR validation).
- On merge to `main`, CI builds and publishes the image to the configured registry (GHCR by default).
- Terraform configurations live in `autonetops-devops/terraform/` — run `terraform init` and `terraform apply` to provision cloud resources (or use Terraform Cloud).
- Kubernetes manifests in `autonetops-devops/k8s/` are applied to your cluster (manually or via a CD step) and reference the container image from the registry.

---

## Quickstart — Local Development

Prerequisites
- Docker & docker-compose
- Make
- (Optional) kubectl if you will apply k8s manifests to a cluster

Build the image locally

```bash
make build
```

Run the application locally using docker-compose

```bash
make run
```

This command runs the image built from `autonetops-devops/docker/Dockerfile` and mounts a local `./data` directory into the container for quick iterative development.

Stop the local environment

```bash
docker-compose -f autonetops-devops/docker/docker-compose.yml down
```

---

## Kubernetes (staging/prod)

To deploy to Kubernetes (assumes a configured kubeconfig pointing at your cluster):

```bash
kubectl apply -f autonetops-devops/k8s/
```

Verify rollout

```bash
kubectl rollout status deployment/autonetops-backend
```

Notes:
- Manifests use the image `ghcr.io/<owner>/autonetops-backend:latest` by default. Update the image tag to match your published image if necessary.
- Consider using a Deployment strategy (rolling updates), resource requests/limits, and probes for production readiness.

---

## Terraform (cloud resources)

The `autonetops-devops/terraform/` directory contains a minimal example (an S3 bucket used as a placeholder for remote state). Before running:

1. Set up AWS credentials in the environment (or configure another provider):

```bash
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
```

2. Initialize and plan:

```bash
make tf-init
make tf-plan
```

If you prefer Terraform Cloud, I can convert these configs to use a Terraform Cloud workspace and VCS-driven runs.

---

## CI/CD (GitHub Actions)

Workflows included:
- `ci.yml`: runs on PRs and pushes to main. Installs dependencies, runs tests (placeholder) and builds the Docker image for validation.
- `publish.yml`: on `main` builds and pushes the published image to GHCR. The workflow uses `GITHUB_TOKEN` to authenticate with GHCR by default.

To publish to Docker Hub instead, add `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` in repository secrets and I can update the workflow to use Docker Hub.

---

## Secrets & Configuration

Store secrets in GitHub repository secrets for Actions, or in your CI platform of choice:

- `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN` (if pushing to Docker Hub)
- `GITHUB_TOKEN` is provided automatically and can be used for GHCR publishing
- `AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY` (for Terraform S3 backend)

Environment variables used by the app (example):
- `DATASTORE_URL` — connection string for the datastore (default in docker-compose uses SQLite file in `./data`)

---

## Development workflow — recommended

1. Create a feature branch: `git checkout -b feat/your-feature`
2. Make code and/or infra changes.
3. Run local checks:
   - `make build` — builds the Docker image
   - `make run` — run locally via docker-compose
   - `make tf-plan` — review infra changes
4. Push changes and open a Pull Request.
5. CI runs validations. Address feedback and squash/fixup commits as needed.
6. Merge to `main`. CI publishes the image and you can run Terraform apply and deploy to Kubernetes.

---

## Architecture diagram (component-level)

```mermaid
graph TD
  subgraph Dev
    dev[Developer]
    dev -->|push| repo[(GitHub repo)]
  end
  subgraph CI/CD
    repo -->|PR/Push| actions[GitHub Actions]
    actions --> build[Build Image]
    build --> publish[Publish Image (GHCR)]
    actions --> test[Test & Lint]
  end
  subgraph Cloud
    publish --> registry[GHCR / Docker Hub]
    registry --> cluster[Kubernetes Cluster]
    terraform --> infra[Cloud Resources (S3, VPC, etc.)]
    infra --> cluster
    actions -->|optional deploy| cluster
  end
```

---

## Troubleshooting & Tips

- If Docker build fails: check base image versions and ensure dependencies are installable in `python:3.11-slim`.
- If Kubernetes pods CrashLoopBackOff: check `kubectl logs` and `kubectl describe pod` to surface liveness/readiness probe failures or missing env vars.
- For Terraform state: do not commit sensitive backend configs. Use remote state with S3+locking (DynamoDB) or Terraform Cloud.

---

## Contributing

Contributions are welcome. Please follow the contributing guidelines in `autonetops-devops/CONTRIBUTING.md`. Open issues for bugs or feature requests and submit PRs against `main` from topic branches.

---

## Roadmap

- Add a Helm chart or Kustomize overlays for environments (dev/staging/prod)
- Add unit/integration tests and automated coverage reporting
- Harden CI with security scanning (container image scanning, tfsec for Terraform)

---

## License & Authors

Licensed under the MIT License — see `autonetops-devops/LICENSE`.

Maintainer: Mohd Dilshad Khan (@mohddilshadkhan2003)
