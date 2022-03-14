resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_mariadb_server" "server" {
  name                = "${var.project_name}-mariadb-server"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = var.project_name
  administrator_login_password = random_password.password.result

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "10.2"

  auto_grow_enabled             = true
  backup_retention_days         = 7
  geo_redundant_backup_enabled  = false
  public_network_access_enabled = true
  ssl_enforcement_enabled       = true
}

resource "azurerm_mariadb_database" "db" {
  name                = lower(var.project_name)
  resource_group_name = azurerm_resource_group.this.name
  server_name         = azurerm_mariadb_server.server.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}