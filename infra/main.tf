# ─────────────────────────────────────────────────────────────────────────────
# Resource Group
# A Resource Group is a logical container for all Azure resources in a project.
# Everything created below lives inside this group.
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    project     = var.app_name
    managed_by  = "terraform"
  }
}

# ─────────────────────────────────────────────────────────────────────────────
# Storage Account
# Azure Storage is an object/blob storage service (similar to AWS S3).
# Storage account names must be globally unique, 3–24 lowercase alphanumeric chars.
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_storage_account" "main" {
  # Replace hyphens because storage account names cannot contain them.
  name                     = replace("st${var.app_name}${var.environment}", "-", "")
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type

  tags = {
    environment = var.environment
    project     = var.app_name
    managed_by  = "terraform"
    owner = "oleg-the-legend"
  }
}

# ─────────────────────────────────────────────────────────────────────────────
# Storage Container
# A container inside the Storage Account — like a bucket/folder for blobs.
# This could be used to store uploaded files, logs, or static assets.
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_storage_container" "main" {
  name                  = "app-data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private" # No public access — blobs require authentication.
}

# ─────────────────────────────────────────────────────────────────────────────
# NOTE: App Service Plan + Linux Web App are intentionally excluded.
# Azure free subscriptions have a VM quota of 0 and cannot provision any
# App Service Plan tier that supports Linux containers (B1 and above).
# To add hosting, upgrade to Pay-As-You-Go or use a paid subscription,
# then add azurerm_service_plan + azurerm_linux_web_app back.
# ─────────────────────────────────────────────────────────────────────────────
