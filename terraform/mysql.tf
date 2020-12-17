resource "azurerm_resource_group" "example" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_mysql_server" "example" {
  name                = var.mysql_server_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  administrator_login          = var.mysql_administrator_login
  administrator_login_password = var.mysql_administrator_login_password

  sku_name   = var.mysql_sku_name
  storage_mb = var.mysql_storage_mb
  version    = var.mysql_version

  auto_grow_enabled                 = var.mysql_auto_grow_enabled
  backup_retention_days             = var.mysql_backup_retention_days
  geo_redundant_backup_enabled      = var.mysql_geo_redundant_backup_enabled
  infrastructure_encryption_enabled = var.mysql_infrastructure_encryption_enabled
  public_network_access_enabled     = var.mysql_public_network_access_enabled
  ssl_enforcement_enabled           = var.mysql_ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.mysql_ssl_minimal_tls_version_enforced
}

# Allow access to Azure services
resource "azurerm_mysql_firewall_rule" "azure" {
  name                = "azure"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

# Allow access office
resource "azurerm_mysql_firewall_rule" "example" {
  name                = "office"
  resource_group_name = azurerm_resource_group.example.name
  server_name         = azurerm_mysql_server.example.name
  start_ip_address    = var.mysql_firewall_rule_start_ip_address
  end_ip_address      = var.mysql_firewall_rule_send_ip_address
}

