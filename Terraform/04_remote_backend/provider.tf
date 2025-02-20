# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.19.0"
    }
  }

  backend "azurerm" {                   #META-ARGUMENT
    resource_group_name  = "DevRG"  
    storage_account_name = "nextopssat23"                      
    container_name       = "tfstate"                       
    key                  = "terraform.tfstate"
    access_key    = "1ESMNZs15OTApUqjzrRoW9seF6+Y2aysTeCqcyDKucIKBMiaZHruCrXF2S9O9VHXaR4WTkV6p2xV+ASt3Mk18A=="   
  } 
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  subscription_id                 = "a355c32e-4a22-4b05-aab4-be236850fa6e"
  features {}
}