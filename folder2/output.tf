output "database_name" {
  description = "SQL database name"
  value       = azurerm_mssql_database.sql_database.name
}