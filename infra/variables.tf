# Variables let you parameterize your infrastructure so you can reuse the same
# Terraform code for different environments (dev, staging, prod) or projects.

variable "resource_group_name" {
  description = "Name of the Azure Resource Group that will contain all resources."
  type        = string
  default     = "rg-fastapi-starter"
}

variable "location" {
  description = "Azure region where resources will be created (e.g. eastus, westeurope)."
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Deployment environment label — used in resource tags (e.g. dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Short name for the application — used as a prefix in resource names."
  type        = string
  default     = "fastapi-starter"
}

variable "container_image" {
  description = "Docker image for the FastAPI app in the format 'REGISTRY/IMAGE:TAG'."
  type        = string
  default     = "tiangolo/uvicorn-gunicorn-fastapi:python3.11"
}

variable "app_service_sku" {
  description = "App Service Plan SKU (size/tier). B1 is the cheapest paid tier that supports Linux containers."
  type        = string
  default     = "B1"
}

variable "storage_account_tier" {
  description = "Performance tier for the Storage Account. Standard is sufficient for most use cases."
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Replication strategy for the Storage Account (LRS = locally redundant, cheapest option)."
  type        = string
  default     = "LRS"
}
