provider "azurerm" {
  version = 1.38
}
resource "azurerm_virtual_network" "objVirtualNetwork" {
  name                = "vn-azcode"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = "rg-azcode"
  tags = {
    environment = "Terraform Networking"
  }
}
resource "azurerm_subnet" "objSubnet" {
  name                 = "sn-azcode"
  resource_group_name  = "rg-azcode"
  virtual_network_name = azurerm_virtual_network.objVirtualNetwork.name
  address_prefix       = "10.0.1.0/24"
}
