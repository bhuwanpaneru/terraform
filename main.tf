provider "azurerm" {
  version         = "1.38.0"
  subscription_id = var.subscription_id
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

resource "azurerm_resource_group" "DevRG" {
  name     = "src-terraform-rg"
  location = "eastus"

  tags = {
    environment = "Dev"
  }
}
