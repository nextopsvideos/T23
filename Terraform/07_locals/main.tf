resource "azurerm_resource_group" "rg1" {
    name        = join("-",[local.prefix,var.rg_name]) #nextops-localrg
    location    = var.rg_location
}

locals {
  rg_ref_name       = azurerm_resource_group.rg1.name
  rg_ref_location   = azurerm_resource_group.rg1.location
  prefix            = "nextops"
}

resource "azurerm_virtual_network" "vnet1" {
    name                = join("-",[local.prefix,var.vnet_name]) #nextops-localvnet
    resource_group_name = local.rg_ref_name
    location            = local.rg_ref_location
    address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "subnet1" {
    name                = var.subnet1_name
    resource_group_name = local.rg_ref_name
    virtual_network_name = azurerm_virtual_network.vnet1.name 
    address_prefixes = var.subnet1_aspace
}

resource "azurerm_subnet" "subnet2" {
    name                = var.subnet2_name
    resource_group_name = local.rg_ref_name
    virtual_network_name = azurerm_virtual_network.vnet1.name 
    address_prefixes = var.subnet2_aspace
}

resource "azurerm_subnet" "subnet3" {
    name                = var.subnet3_name
    resource_group_name = local.rg_ref_name
    virtual_network_name = azurerm_virtual_network.vnet1.name 
    address_prefixes = var.subnet3_aspace
}