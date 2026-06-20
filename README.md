# Terraform Azure FastAPI Starter

A learning project that provisions basic Azure infrastructure for a containerized FastAPI app using Terraform.

> Not production-ready — built to practice IaC concepts and build a DevOps portfolio piece.

## What It Creates

- Resource Group
- Storage Account + private blob container
- App Service Plan (Linux)
- Linux Web App running a Docker container

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) + an Azure subscription

## Usage

```bash
az login

cd infra
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars as needed

terraform init
terraform plan
terraform apply

# when done
terraform destroy
```

## Key Variables

| Variable | Default | Description |
|---|---|---|
| `location` | `eastus` | Azure region |
| `environment` | `dev` | Environment label |
| `app_name` | `fastapi-starter` | Prefix for resource names |
| `container_image` | `tiangolo/uvicorn-gunicorn-fastapi:python3.11` | Docker image to deploy |
| `app_service_sku` | `B1` | Compute size (`F1` free tier does not support Linux containers) |

## CI

GitHub Actions runs `terraform fmt -check`, `terraform init`, and `terraform validate` on every push and pull request.
