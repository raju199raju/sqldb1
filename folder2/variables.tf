variable "server_id" {
  type        = string
  description = "SQL server id"
  default = "/subscriptions/060c7910-de04-45a3-9953-ad495ae2be2b/resourceGroups/example-resources128/providers/Microsoft.Sql/servers/newserv12"
}

variable "server_name" {
  type        = string
  description = "SQL server name"
  default = "newserv12"
}

variable "elastic_pool_id" {
  type        = string
  description = "Elastic Pool id"
  default = "/subscriptions/060c7910-de04-45a3-9953-ad495ae2be2b/resourceGroups/example-resources128/providers/Microsoft.Sql/servers/newserv12/elasticPools/poolio"
}

variable "database_name" {
  type        = string
  description = "SQL database name"
  default = "sqldb-cif2-hwca2-aa-miningkpi-dev"
}

variable "collation" {
  type        = string
  description = "Specifies the collation of the database. Changing this forces a new resource to be created."
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "read_scale" {
  type        = string
  description = "If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases."
  default     = "false"
}

variable "administrator_login" {
  type        = string
  description = "Optional: SQL server administrator login, needed to create SQL users"
  default = "sqladminuser"
}

variable "administrator_login_password" {
  type        = string
  description = "Optional: SQL server administrator login password, needed to create SQL users"
  default = "Adminpassword@12"
}

variable "sql_users" {
  type = map(object({
    roles    = list(string)
    password = string
  }))
  description = "Define SQL users and their roles for the database"
  default     = {}
}

variable "key_vault_id" {
  type        = string
  description = "Slot key vault ID"
  default = "/subscriptions/060c7910-de04-45a3-9953-ad495ae2be2b/resourceGroups/example-resources128/providers/Microsoft.KeyVault/vaults/examplekeyvault-raju8090"
}
