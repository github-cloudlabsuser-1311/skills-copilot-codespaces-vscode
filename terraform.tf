# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Define variables
variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "location" {
  description = "Location for the storage account"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create a storage account
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Optional: Enable advanced settings
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
}