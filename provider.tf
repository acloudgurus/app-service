terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
 subscription_id = "#{subscriptionID}"
  skip_provider_registration = true 
  tenant_id = "#{tenantID}"
  client_id = "#{clientID}"
  client_secret = "#{clientSecret}"

 features {}
}
#terraform import 'azurerm_app_service_certificate.app_service_certificate["wmsre-linuxapp-dev.genscape.com"]' "/subscriptions/240be98a-3c73-49fa-bea8-d8fa590c6389/resourceGroups/sre-shared-nonprod/providers/Microsoft.Web/certificates/wm-lin-webapp-cert"
