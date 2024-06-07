# 
# This module is owned by SRE LandingZone's Team 
# 

module "linux_web_app" {
  source  = "../../linux_web_app"
  app_service_name    = "aasp2"
  location            = "East US"
  resource_group_name = "test-rg"
  service_plan_id     = "/subscriptions/#{subscriptionID}/resourcegroups/test-rg/providers/Microsoft.Web/serverFarms/testasp"

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
