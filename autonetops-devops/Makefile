# Makefile for autonetops-devops
.PHONY: build run stop logs test tf-init tf-plan k8s-apply

APP_ENV ?= development
APP_PORT ?= 8000
IMAGE_TAG ?= autonetops/backend:local

build:
	docker build -t $(IMAGE_TAG) ./autonetops-devops/docker

run:
	APP_ENV=$(APP_ENV) APP_PORT=$(APP_PORT) IMAGE_NAME=$(IMAGE_TAG) docker-compose -f autonetops-devops/docker/docker-compose.yml up --build

stop:
	docker-compose -f autonetops-devops/docker/docker-compose.yml down

logs:
	docker-compose -f autonetops-devops/docker/docker-compose.yml logs -f app

test:
	python -m compileall autonetops-devops/docker/src

tf-init:
	terraform -chdir=autonetops-devops/terraform init

tf-plan:
	terraform -chdir=autonetops-devops/terraform plan

k8s-apply:
	kubectl apply -f autonetops-devops/k8s/
