# Infrastructure

## Resources

| Resource | Name | Notes |
|---|---|---|
| Resource Group | `rg-fastapi-starter` | Container for all resources |
| Storage Account | `st{app_name}{environment}` | Hyphens stripped — Azure naming constraint |
| Storage Container | `app-data` | Private blob container for app data |
| Storage Container | `test-data` | Private blob container for testing |

## Constraints

App Service Plan and Linux Web App are excluded. Azure free subscriptions enforce a VM quota of 0, which blocks any App Service Plan that supports Linux containers (B1+). Re-adding them requires a Pay-As-You-Go subscription.

## Naming

Resource names are composed from `app_name` and `environment` variables, making the same config reusable across environments. Changing `environment` forces a replacement of the Storage Account (Azure does not support renaming).

## Auth

Authentication uses the Azure CLI (`az login`). No credentials are stored in the Terraform config.

## CI

GitHub Actions runs `terraform fmt -check`, `terraform init -backend=false`, and `terraform validate` on every push and pull request. No Azure credentials required.
