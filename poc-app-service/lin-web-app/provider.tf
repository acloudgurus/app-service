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
  subscription_id = "#{AzureAccount.SubscriptionNumber}"
  skip_provider_registration = true 
  tenant_id = "#{AzureAccount.TenantId}"
  client_id = "#{AzureAccount.Client}"
  client_secret = "#{AzureAccount.Password}"
    features {}
}
