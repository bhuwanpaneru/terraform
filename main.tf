terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

data "external" "rg" {
    program = ["/bin/bash","./script.sh"]

    query = {
        group_name = var.group_name
    }
}

resource "azurerm_resource_group" "DevRG" {
  count = data.external.rg.result.exists == "true" ? 0 : 1
  name     = var.rgName
  location = var.location

  tags = {
    environment = "Dev"
  }
}
