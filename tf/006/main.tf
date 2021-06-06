provider "azurerm" {
  version = 1.38
}
resource "azurerm_resource_group" "objResourceGroup" {
  name     = "rg-azcode"
  location = "eastus"
}

resource "azurerm_app_service_plan" "objAppServicePlan" {
  name                = "ap-azcode-006"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.objResourceGroup.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "objAppService" {
  name                = "as-azcode-006"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.objResourceGroup.name
  app_service_plan_id = azurerm_app_service_plan.objAppServicePlan.id


  site_config {
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}
