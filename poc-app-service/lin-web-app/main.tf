# 
# This module is owned by SRE LandingZone's Team 
# 
terraform {
  backend "azurerm" {
    storage_account_name = "#{StorageAccountName}"
    container_name       = "#{ContainerName}"
    key                  = "#{Octopus.Environment.Name |ToLower}.terraform.tfstate"
    access_key           = "#{AccessKey}"
  }
}


module "linux_web_app" {
  source  = "../../linux_web_app"
  app_service_name    = "aasp2"
  location            = "East US"
  resource_group_name = "test-rg"
  service_plan_id     = "/subscriptions/4a9ac668-c3d5-4a20-859a-c680184367b8/resourceGroups/test-rg/providers/Microsoft.Web/serverFarms/testasp"

  app_settings = {
    DB = "WMSRE"
  }

  site_config = {
    application_stack = {
      current_stack  = "dotnet"
      dotnet_version = "v7.0"
    }
  }
}
