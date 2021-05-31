provider "azurerm" {
  version = 1.38
  }
resource "azurerm_network_security_group" "objNetworkSecurityGroup" {
  name                = "nsg-azcode"
  location            = "eastus"
  resource_group_name = "rg-azcode"
}
resource "azurerm_network_security_rule" "objInHttp" {
  name                        = "inhttp-azcode"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "80"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-azcode"
  network_security_group_name = azurerm_network_security_group.objNetworkSecurityGroup.name
}
resource "azurerm_network_security_rule" "objInHttps" {
  name                        = "inhttps-azcode"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "443"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-azcode"
  network_security_group_name = azurerm_network_security_group.objNetworkSecurityGroup.name
}
resource "azurerm_network_security_rule" "objInSsh" {
  name                        = "inssh-azcode"
  priority                    = 1100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "rg-azcode"
  network_security_group_name = azurerm_network_security_group.objNetworkSecurityGroup.name
}
