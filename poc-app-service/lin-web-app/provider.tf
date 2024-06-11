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
  subscription_id = "#{Azure.SubscriptionId}"
  skip_provider_registration = true 
  tenant_id = "#{Azure.TenantID}"
  client_id = "#{Azure.ApplicationID}"
  client_secret = "#{Azure.Password}"
    features {}
}
