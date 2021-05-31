provider "azurerm" {
  version = 1.38
}
resource "azurerm_resource_group" "objResourceGroup" {
  name      = "rg-azcode-005"
  location  = "eastus"
}
resource "azurerm_virtual_network" "objVirtualNetwork" {
    name                = "vn-azcode-005"
    address_space       = ["10.0.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.objResourceGroup.name

    tags = {
        environment = "Terraform VNET"
    }
}
resource "azurerm_subnet" "objSubnet" {
    name                 = "sn-azcode-005"
    resource_group_name = azurerm_resource_group.objResourceGroup.name
    virtual_network_name = azurerm_virtual_network.objVirtualNetwork.name
    address_prefix       = "10.0.1.0/24"
}

resource "azurerm_public_ip" "objPublicIp" {
  name                = "ip-azcode-005"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.objResourceGroup.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "objNetworkInterface" {
  name                = "ni-azcode-005"
  location            = "eastus"
  resource_group_name = azurerm_resource_group.objResourceGroup.name

    ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.objSubnet.id
    private_ip_address_allocation  = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.objPublicIp.id
  }
}

resource "azurerm_storage_account" "objStorageAccount" {
  name                     = "saazcode005"
  resource_group_name      = azurerm_resource_group.objResourceGroup.name
  location                 = "eastus"
   account_tier            = "Standard"
   account_replication_type = "LRS"

   tags = {
    environment = "Boot Diagnostic Storage"
    CreatedBy = "Admin"
   }
  }

resource "azurerm_virtual_machine" "objVirtualMachine" {
  name                  = "vm-azcode-005"
  location              = "eastus"
  resource_group_name   = azurerm_resource_group.objResourceGroup.name
  network_interface_ids = [azurerm_network_interface.objNetworkInterface.id]
  vm_size               = "Standard_B1s"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk1"
    disk_size_gb      = "128"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "os-azcode-005"
    admin_username = "azureuser"
    admin_password = "Password12345!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

boot_diagnostics {
        enabled     = "true"
        storage_uri = azurerm_storage_account.objStorageAccount.primary_blob_endpoint
    }
}
