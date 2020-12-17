variable "resource_group" {
  type    = string
  default = "rg-terraform"
}

variable "prefix" {
  type    = string
  default = "terraform"
}

variable "location" {
  type    = string
  default = "japaneast"
}

variable "runtime_stack" {
  type    = string
  default = "NODE|12-lts"
  # default = "PYTHON|3.8"
}

variable "functions_worker_runtime" {
  type    = string
  default = "node"
  # default = "python"
}

#variable "azure_client_id" {
#  type = string
#}
#
#variable "azure_client_secret" {
#  type = string
#}

variable "mysql_server_name" {
  type    = string
  default = "xxxx"
}

variable "mysql_administrator_login" {
  type    = string
  default = "mysqladministrator"
}

variable "mysql_administrator_login_password" {
  type    = string
  default = "wDs4meYrBTeHzjEe"
}

variable "mysql_sku_name" {
  type    = string
  default = "GP_Gen5_2"
}

variable "mysql_storage_mb" {
  type    = string
  default = "5120"
}

variable "mysql_version" {
  type    = string
  default = "8.0"
}

variable "mysql_auto_grow_enabled" {
  type    = string
  default = "true"
}

variable "mysql_backup_retention_days" {
  type    = string
  default = "7"
}

variable "mysql_geo_redundant_backup_enabled" {
  type    = string
  default = "false"
}

variable "mysql_infrastructure_encryption_enabled" {
  type    = string
  default = "false"
}

variable "mysql_public_network_access_enabled" {
  type    = string
  default = "true"
}

variable "mysql_ssl_enforcement_enabled" {
  type    = string
  default = "true"
}

variable "mysql_ssl_minimal_tls_version_enforced" {
  type    = string
  default = "TLS1_2"
}

variable "mysql_firewall_rule_start_ip_address" {
  type    = string
  default = "40.113.200.201"
}

variable "mysql_firewall_rule_send_ip_address" {
  type    = string
  default = "40.113.200.201"
}