terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
  subscription_id = "#{AzureAccount.SubscriptionId}"
  skip_provider_registration = true 
  tenant_id = "#{AzureAccount.TenantID}"
  client_id = "#{AzureAccount.ApplicationID}"
  client_secret = "#{AzureAccount.Password}"

 features {}
}
