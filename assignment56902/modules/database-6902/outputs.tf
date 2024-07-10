output "postgres_server_name" {
  value = azurerm_postgresql_server.postgres_server.name
}

output "postgres_db_name" {
  value = azurerm_postgresql_database.postgres_db.name
}

output "postgres_server_fqdn" {
  value = azurerm_postgresql_server.postgres_server.fqdn
}
