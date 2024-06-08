terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.103"
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
