terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.20.0"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "example" {
  name     = var.resource_group
  location = var.location

}

resource "azurerm_app_service_plan" "example" {
  name                = "${var.prefix}-asp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "PremiumV2"
    size = "P1v2"
    # number of instances
    capacity = 2
  }

}
resource "azurerm_app_service" "example" {
  name                = "${var.prefix}-webapp"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  app_service_plan_id = azurerm_app_service_plan.example.id

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  logs {
    http_logs {
      file_system {
        retention_in_days = 0
        retention_in_mb   = 35
      }

    }
  }

  # auth_settings {
  #   enabled                       = true
  #   default_provider              = "AzureActiveDirectory"
  #   unauthenticated_client_action = "RedirectToLoginPage"
  #   active_directory {
  #     client_id     = var.azure_client_id
  #     client_secret = var.azure_client_secret
  #   }
  # }

  site_config {
    always_on        = true
    linux_fx_version = var.runtime_stack
    # https://docs.microsoft.com/ja-jp/azure/app-service/configure-language-python
    # app_command_line = "gunicorn --bind=0.0.0.0 --timeout 600 --chdir app main:app"
    app_command_line = ""
    ftps_state       = "Disabled"
  }

}

resource "azurerm_function_app" "example" {
  name                       = "${var.prefix}-functionapp"
  location                   = azurerm_resource_group.example.location
  resource_group_name        = azurerm_resource_group.example.name
  app_service_plan_id        = azurerm_app_service_plan.example.id
  storage_account_name       = azurerm_storage_account.example.name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key

  https_only = true
  version    = "~3"
  os_type    = "linux"

  site_config {
    always_on        = true
    linux_fx_version = var.runtime_stack
    ftps_state       = "Disabled"
    min_tls_version  = 1.2
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"              = "1"
    "FUNCTIONS_WORKER_RUNTIME"              = var.functions_worker_runtime
    "APPINSIGHTS_INSTRUMENTATIONKEY"        = azurerm_application_insights.example.instrumentation_key
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = "InstrumentationKey=${azurerm_application_insights.example.instrumentation_key};IngestionEndpoint=https://japaneast-0.in.applicationinsights.azure.com/"
  }

}

# Storage Resources for Function App
resource "azurerm_storage_account" "example" {
  name                     = "${var.prefix}test1214storage"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "example" {
  name                  = "contents"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

# App Insights for Function App
resource "azurerm_application_insights" "example" {
  name                = "${var.prefix}-appinsights"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  application_type    = "web"

  # https://github.com/terraform-providers/terraform-provider-azurerm/issues/1303
  tags = {
    "hidden-link:${azurerm_resource_group.example.id}/providers/Microsoft.Web/sites/${var.prefix}func" = "Resource"
  }
}
