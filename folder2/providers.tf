terraform {
  # Set the terraform required version
  required_version = ">= 0.14.2"

  # Register common providers
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
  }

  # Persist state in a storage account
  backend "azurerm" {
  }
}

# Configure the Azure Provider
provider "azurerm" {
  skip_provider_registration = true
  features {}
}
