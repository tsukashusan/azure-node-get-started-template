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