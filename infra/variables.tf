variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
  default     = "rg-fastapi-starter"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westus"
}

variable "environment" {
  description = "Environment label (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "app_name" {
  description = "Application name prefix used in resource names"
  type        = string
  default     = "fastapi-starter"
}

variable "storage_account_tier" {
  description = "Storage Account performance tier"
  type        = string
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Storage Account replication strategy"
  type        = string
  default     = "LRS"
}
