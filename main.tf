# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used

#terraform {
#  required_version = ">= 0.12, < 0.13"
#}

subscription_id= var.subscriptionID
#client_id = var.clientID
#client_secret = var.clientSecret
tenant_id = var.tenantID

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

#provider "azurerm" {
# version = "~> 1.34.0"
#}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Hub RG
resource "azurerm_resource_group" "rg" {
  name     = "srs-d-eus-test-tf"
  location = "eastus"
  #name     = var.rgName
  #location = var.location
}

#######################################################################
############# Setup a shared NSG used across all RGs ##################
#######################################################################
#
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

#######################################################################
####################### Database setup ################################
#######################################################################
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

####################### Start Sql server #############################
#resource "azurerm_mssql_database" "sqldb" {
#  name      = "db01"
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

################################# OR ##################################
#resource "azurerm_sql_database" "sqldb" {
#  name                             = "sql-db"
#  resource_group_name              = "${azurerm_resource_group.rg.name}"
#  location                         = "${azurerm_resource_group.rg.location}"
#  server_name                      = "${azurerm_sql_server.ss.name}"
#  edition                          = "Basic"
#  collation                        = "SQL_Latin1_General_CP1_CI_AS"
#  create_mode                      = "Default"
#  requested_service_objective_name = "Basic"
#}

########################## End sql server ############################

# Enables the "Allow Access to Azure services" box as described in the API docs
# https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
#resource "azurerm_sql_firewall_rule" "fw" {
#  name                = "allow-azure-services"
#  resource_group_name = azurerm_resource_group.rg.name
#  server_name         = azurerm_sql_server.ss.name
#  start_ip_address    = "0.0.0.0"
#  end_ip_address      = "0.0.0.0"
#}

#######################################################################
########################## End Db script ##############################
#######################################################################
