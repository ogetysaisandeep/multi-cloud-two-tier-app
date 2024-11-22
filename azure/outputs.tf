output "frontend_ip" {
  value = azurerm_linux_virtual_machine.frontend.public_ip_address
}

output "backend_db_connection_string" {
  value = azurerm_sql_database.sql_database.connection_string
}
