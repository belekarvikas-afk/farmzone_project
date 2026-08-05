terraform {
    required_providers {
        azurerm ={
            source ="hashicorp/azurerm"
            version = "5.0.0"
        }
    }
    backend "azurerm" {
    resource_group_name = "b18g35-common-rg"
    storage_account_name = "b18g35storageaccount"
    container_name = "tfstatefiles"
    key = "vikashardcode.tfstate"
}
}

provider "azurerm" {
    features {}
}
