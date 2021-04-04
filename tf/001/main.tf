provider "azurerm" {
  version = 1.38
}
resource "azurerm_resource_group" "objResourceGroup" {
  name      = "rg-azcode"
  location  = "eastus"
}
resource "azurerm_storage_account" "objStorageAccount" {
  name                = "saazcode"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.objResourceGroup.name
  account_tier              = "Standard"
  account_replication_type  = "GRS"
}
resource "azurerm_storage_container" "objStorageContainer" {
  name                  = "sc-azcode"
  storage_account_name  = azurerm_storage_account.objStorageAccount.name
  container_access_type = "private"
}
resource "azurerm_storage_blob" "objStorageBlob" {
  name                    = "sb-azcode"
  resource_group_name     = azurerm_resource_group.objResourceGroup.name
  storage_account_name    = azurerm_storage_account.objStorageAccount.name
  storage_container_name  = azurerm_storage_container.objStorageContainer.name
  type                    = "Block"
}
