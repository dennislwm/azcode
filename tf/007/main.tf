provider "azurerm" {
  version = 1.38
}
resource "azurerm_resource_group" "objResourceGroup" {
  name     = "rg-azcode"
  location = "eastus"
}

resource "azurerm_mysql_server" "objMysqlServer" {
  name                = "ms-azure-007"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.objResourceGroup.name

  sku {
    name     = "B_Gen5_2"
    capacity = 2
    tier     = "Basic"
    family   = "Gen5"
  }

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = "mysqluser"
  administrator_login_password = "easytologin4once!"
  version                      = "5.7"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_mysql_database" "objMysqlDatabase" {
  name                = "md-azure-007"
  resource_group_name = azurerm_resource_group.objResourceGroup.name
  server_name         = azurerm_mysql_server.objMysqlServer.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
