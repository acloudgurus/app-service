terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
  subscription_id = "4a9ac668-c3d5-4a20-859a-c680184367b8"
  skip_provider_registration = true 
  tenant_id = "66167829-0104-44d5-9f0c-90583021fcab"
  #client_id = "e5a77fc6-9445-4d05-9cce-d1ec0fd97b96"
  #client_secret = "7ds8Q~uB7a2hJb5Gho78QDEt94OZB7CcpXyVucAw"

 features {}
}
#terraform import 'azurerm_app_service_certificate.app_service_certificate["wmsre-linuxapp-dev.genscape.com"]' "/subscriptions/240be98a-3c73-49fa-bea8-d8fa590c6389/resourceGroups/sre-shared-nonprod/providers/Microsoft.Web/certificates/wm-lin-webapp-cert"