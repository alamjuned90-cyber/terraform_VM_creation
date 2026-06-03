terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.64.0"
    }
  }
}
provider "azurerm" {
  features {}
}
variable "rg_name" {
  default = ["rg_1", "rg_2", "rg_3"]
}
resource "azurerm_resource_group" "rg" {
  for_each = toset(var.rg_name)
  name     = each.key
  location = "West Europe"
}

resource "azurerm_storage_account" "rg2" {
  depends_on               = [azurerm_resource_group.rg]
  name                     = "qwertasdfg023"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}






