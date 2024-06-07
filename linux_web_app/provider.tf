terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.103.1"
    }
  }
}

provider "azurerm" {
  subscription_id = "240be98a-3c73-49fa-bea8-d8fa590c6389"
  skip_provider_registration = true 
  tenant_id = "39981c07-b49b-43c2-a3ad-ffb43ab32375"
  #client_id = "e5a77fc6-9445-4d05-9cce-d1ec0fd97b96"
  #client_secret = "7ds8Q~uB7a2hJb5Gho78QDEt94OZB7CcpXyVucAw"

 features {}
}