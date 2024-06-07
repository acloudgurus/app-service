output "service_plan_id" {
  description = "ID of the Service Plan"
  value       = var.service_plan_id
}

output "app_service_name" {
  description = "Name of the App Service"
  value       = azurerm_linux_web_app.app_service_linux.name
}

output "app_service_default_site_hostname" {
  description = "The Default Hostname associated with the App Service"
  value       = azurerm_linux_web_app.app_service_linux.default_hostname
}

output "app_service_outbound_ip_addresses" {
  description = "Outbound IP adresses of the App Service"
  value       = split(",", azurerm_linux_web_app.app_service_linux.outbound_ip_addresses)
}

output "application_insights_name" {
  description = "Name of the Application Insights associated to the App Service"
  value       = try(local.app_insights.name, null)
}