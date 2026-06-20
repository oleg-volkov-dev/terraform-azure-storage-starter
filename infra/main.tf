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
# App Service Plan
# The App Service Plan defines the region, OS, and compute size (SKU) for the
# web app. Multiple web apps can share the same plan to share cost.
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_service_plan" "main" {
  name                = "asp-${var.app_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  os_type             = "Linux" # Required for Docker container deployments.
  sku_name            = var.app_service_sku

  tags = {
    environment = var.environment
    project     = var.app_name
    managed_by  = "terraform"
  }
}

# ─────────────────────────────────────────────────────────────────────────────
# Linux Web App
# Azure App Service hosts the FastAPI container. Azure pulls the image from
# Docker Hub (or any registry) and runs it on the plan defined above.
# ─────────────────────────────────────────────────────────────────────────────
resource "azurerm_linux_web_app" "main" {
  name                = "app-${var.app_name}-${var.environment}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.main.id

  # App settings are surfaced as environment variables inside the container.
  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
    ENVIRONMENT                         = var.environment
    APP_NAME                            = var.app_name

    # Pass storage account credentials so the FastAPI app can access blobs.
    STORAGE_ACCOUNT_NAME = azurerm_storage_account.main.name
    STORAGE_ACCOUNT_KEY  = azurerm_storage_account.main.primary_access_key
  }

  site_config {
    # Tell App Service we are deploying a Docker container.
    application_stack {
      docker_image_name   = var.container_image
      docker_registry_url = "https://index.docker.io"
    }

    # Enforce HTTPS — redirect plain HTTP requests automatically.
    # (App Service handles the TLS termination for you.)
  }

  https_only = true

  tags = {
    environment = var.environment
    project     = var.app_name
    managed_by  = "terraform"
  }
}
