# Outputs surface key information after `terraform apply` completes.
# They are also useful when one Terraform module consumes another module's resources.

output "resource_group_name" {
  description = "Name of the provisioned Resource Group."
  value       = azurerm_resource_group.main.name
}

output "storage_account_name" {
  description = "Name of the provisioned Storage Account."
  value       = azurerm_storage_account.main.name
}

output "storage_container_name" {
  description = "Name of the blob container inside the Storage Account."
  value       = azurerm_storage_container.main.name
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan."
  value       = azurerm_service_plan.main.name
}

output "web_app_name" {
  description = "Name of the Linux Web App resource."
  value       = azurerm_linux_web_app.main.name
}

output "web_app_url" {
  description = "Public HTTPS URL where the FastAPI app is reachable."
  value       = "https://${azurerm_linux_web_app.main.default_hostname}"
}

output "web_app_hostname" {
  description = "Default hostname assigned by Azure (without the https:// prefix)."
  value       = azurerm_linux_web_app.main.default_hostname
}
