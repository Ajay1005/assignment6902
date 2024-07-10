terraform {
  backend "azurerm" {
    resource_group_name  = "tfstaten01656902RG"
    storage_account_name = "tfstaten01656902sa"
    container_name       = "tfstatefiles"
    key                  = "tfstate"
  }
}

