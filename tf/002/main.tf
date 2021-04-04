provider "azurerm" {
  version = 1.38
}
terraform {
  backend "azurerm" {
    resource_group_name   = "rg-azcode"
    storage_account_name  = "saazcode"
    container_name        = "sc-azcode"
    key                   = "terraform.state"
  }
}
resource "azurerm_resource_group" "objResourceGroup" {
  name      = "rg-azcode-002"
  location  = "eastus"
}
