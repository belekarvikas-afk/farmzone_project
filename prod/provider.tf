terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.81.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "b18g35-common-rg"
    storage_account_name = "b18g35storageaccount"
    container_name       = "dilipvikas"
    key                  = "vikashubandspoke.tfstate"
  }
}


provider "azurerm" {
  features {}
}