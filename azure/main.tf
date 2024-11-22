provider "azurerm" {
  features = {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "${var.app_name}-rg"
  location = var.location
}

# Frontend VM
resource "azurerm_linux_virtual_machine" "frontend" {
  name                  = "${var.app_name}-frontend"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  size                  = var.vm_size
  admin_username        = var.admin_user
  admin_password        = var.admin_password

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# Backend SQL Database
resource "azurerm_sql_server" "sql_server" {
  name                         = "${var.app_name}-sqlserver"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  administrator_login          = var.admin_user
  administrator_login_password = var.admin_password
}

resource "azurerm_sql_database" "sql_database" {
  name                = "${var.app_name}_db"
  resource_group_name = azurerm_resource_group.main.name
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = "Basic"
}
