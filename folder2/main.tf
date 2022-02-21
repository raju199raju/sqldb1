# Temporary for credential generation
resource "random_password" "miningcostdata_database_user_password" {
  length           = 16
  special          = true
  min_special      = 1
  min_numeric      = 1
  min_upper        = 1
  min_lower        = 1
  override_special = "$%&-_+{}<>"
}

resource "azurerm_key_vault_secret" "miningcostdata_user_secret" {
  name         = "auto-miningcostdata-sqldb-admin"
  value        = "miningcostdata_sqldb_admin"
  key_vault_id = var.key_vault_id
  content_type = ""

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_key_vault_secret" "miningcostdata_pw_secret" {
  name         = "auto-miningcostdata-sqldb-password"
  value        = random_password.miningcostdata_database_user_password.result
  key_vault_id = var.key_vault_id
  content_type = ""

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

# create sql database
//module "sql_database_miningcostdata" {
//  source                       = "../../modules/mssql-database"
//  server_id                    = var.sql_server_id
//  server_name                  = var.sql_server_name
// database_name                = "sqldb-${var.app_name}-${var.deployment_stamp_name}-${var.slot_name}-miningcostdata-${var.environment}"
//  administrator_login          = var.sql_server_administrator_login
//  administrator_login_password = var.sql_server_administrator_login_password
//  elastic_pool_id              = var.sql_server_elastic_pool_id
//  sql_users = {
//    "miningcostdata_sqldb_admin" = {
//      roles    = ["db_owner"]
//      password = random_password.miningcostdata_database_user_password.result
//    }
//  }
//}

resource "azurerm_mssql_database" "sql_database" {
  name            = var.database_name
  server_id       = var.server_id
  sku_name        = "ElasticPool"
  collation       = var.collation
  elastic_pool_id = var.elastic_pool_id

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "mssql_login" "sql_login" {
  server {
    host = "${var.server_name}.database.windows.net"
    login {
      username = "testadmin"
      password = "Virtual@12345"
    }
  }
  login_name = "miningcostdata_sqldb_admin"
  password   = random_password.miningcostdata_database_user_password.result
}

# Create SQL users on the application database
resource "mssql_user" "sql_user" {
  server {
    host = "${var.server_name}.database.windows.net"
    login {
      username = "testadmin"
      password = "Virtual@12345"
    }
  }
  database   = azurerm_mssql_database.sql_database.name
  username   = "miningcostdata_sqldb_admin"
  login_name = "miningcostdata_sqldb_admin"
  roles      = [ "db_owner" ]
  depends_on = [mssql_login.sql_login]
}


resource "azurerm_key_vault_secret" "miningcostdata_secret" {
  name         = "auto-miningcostdata-sqldb-connection-string"
  value        = "Server=tcp:newsqlsever.database.windows.net,1433;Initial Catalog=sqldb-cif2-hwca2-aa-miningkpi-dev;Persist Security Info=False;User ID=miningcostdata_sqldb_admin;Password=${random_password.miningcostdata_database_user_password.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  key_vault_id = var.key_vault_id
  content_type = ""

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}


