# Makefile for autonetops-devops
.PHONY: build run test tf-init tf-plan k8s-apply

build:
	docker build -t autonetops/backend:local ./autonetops-devops/docker

run:
	docker-compose -f autonetops-devops/docker/docker-compose.yml up --build

test:
	@echo "No tests defined"

tf-init:
	terraform -chdir=autonetops-devops/terraform init

tf-plan:
	terraform -chdir=autonetops-devops/terraform plan

k8s-apply:
	kubectl apply -f autonetops-devops/k8s/
