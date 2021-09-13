# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

#terraform {
#  required_version = ">= 0.12, < 0.13"
#}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" 
      version = "~>2.5.0"
   }
  }
  #required_version = ">= 0.12, < 0.13"
}

#provider "azurerm" {
# version = "~> 1.34.0"
#}

# Configure the Microsoft Azure Provider
  provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}


# Hub RG
resource "azurerm_resource_group" "rg" {
  name     = var.rgName
  location = var.location
  tags = {
    environment = "Dev"
  }
}

# Setup a shared NSG used across all RGs
resource "azurerm_network_security_group" "basic-nsg" {
  name                = "${azurerm_resource_group.rg.name}-mgmt-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "allow-ssh"
    description                = "Allow SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

#######################################################################
# HUB Public IP SECTION
#resource "azurerm_public_ip" "hub-pip" {
#  name                = "hub-pip"
#  location            = azurerm_resource_group.rg.location
#  resource_group_name = azurerm_resource_group.rg.name
#  allocation_method   = "Dynamic"
#}

#resource "azurerm_storage_account" "st" {
#  name                     = "irsdeunahu01st"
#  resource_group_name      = azurerm_resource_group.rg.name
#  location                 = azurerm_resource_group.rg.location
#  account_tier             = "Standard"
#  account_replication_type = "LRS"
#}

#resource "azurerm_sql_server" "ss" {
#  name                         = "irsdeunahu01-ss"
#  resource_group_name          = azurerm_resource_group.rg.name
#  location                     = azurerm_resource_group.rg.location
#  version                      = "12.0"
#  administrator_login          = "sysadmin"
#  administrator_login_password = "Sync#150"
#}

#resource "azurerm_mssql_database" "sqldb" {
#  name      = "${azurerm_storage_account.st.name}-${var.dbName}"
#  server_id = azurerm_sql_server.ss.id
#  #  resource_group_name = azurerm_resource_group.rg.name
#  #  storage_account_name  = azurerm_storage_account.st.name
#  collation    = "SQL_Latin1_General_CP1_CI_AS"
#  license_type = "LicenseIncluded"
#  max_size_gb  = 1
#  #read_scale   = true
#  sku_name     = "Basic"
#  #zone_redundant = true #this is required sku > basic
#}


