resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = var.environment
    project     = var.app_name
    managed_by  = "terraform"
  }
}

resource "azurerm_storage_account" "main" {
  # hyphens not allowed in storage account names
  name                     = replace("st${var.app_name}${var.environment}", "-", "")
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type

  tags = {
    environment = var.environment
    project     = var.app_name
    managed_by  = "terraform"
    owner       = "oleg-the-legend"
  }
}

resource "azurerm_storage_container" "main" {
  name                  = "app-data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "test" {
  name                  = "test-data"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "private"
}
