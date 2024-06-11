terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
  #subscription_id = "4a9ac668-c3d5-4a20-859a-c680184367b8"
  #skip_provider_registration = true 
  #tenant_id = "66167829-0104-44d5-9f0c-90583021fcab"
  #client_id = "2a06646a-bda0-49f7-bd72-a714e1dfb122"
  #client_secret = "PHg8Q~tW4pWQJ2EUGS9ZWW3hGH~6FTNUbPTGmbeN"

 features {}
}
