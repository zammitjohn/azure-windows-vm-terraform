terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.61.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "demo" {
  name     = "${var.prefix}-rg-${join("", split(":", timestamp()))}" # removing the colons since Azure doesn't allow them.
  location = var.location                                            # this is where RG metadata is saved. Resources can be assigned to different region.
}