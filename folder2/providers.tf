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

terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.0.0"
    }

    mssql = {
      source  = "betr-io/mssql"
      version = "0.2.0"
    }
  }
}