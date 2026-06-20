# Terraform Azure FastAPI Starter

Provisions basic Azure storage infrastructure using Terraform. Built as a DevOps/IaC portfolio project.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

## Usage

```bash
az login

cd infra
cp terraform.tfvars.example terraform.tfvars

terraform init
terraform plan
terraform apply

terraform destroy  # when done
```

## Variables

| Variable | Default | Description |
|---|---|---|
| `resource_group_name` | `rg-fastapi-starter` | Resource Group name |
| `location` | `westus` | Azure region |
| `environment` | `dev` | Environment label |
| `app_name` | `fastapi-starter` | Resource name prefix |
| `storage_account_tier` | `Standard` | Storage tier |
| `storage_replication_type` | `LRS` | Replication strategy |

See [INFRASTRUCTURE.md](INFRASTRUCTURE.md) for architecture details and constraints.
