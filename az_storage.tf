resource "azurerm_storage_account" "this" {
  name                     = var.project_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "this" {
  name                  = var.project_name
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "environment" {
  name                   = ".env"
  storage_account_name   = azurerm_storage_account.this.name
  storage_container_name = azurerm_storage_container.this.name
  type                   = "Block"
  source_content         = <<EOF
  DB_NAME=${azurerm_mariadb_database.db.name}
  DB_PASSWORD=${azurerm_mariadb_server.server.administrator_login_password}
  DB_HOST=${azurerm_mariadb_server.server.fqdn}
  DB_USER=${azurerm_mariadb_server.server.administrator_login}
  EOF
}