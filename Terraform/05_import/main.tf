resource "azurerm_resource_group" "rg1" {
    name        = "NextOpsRG01"
    location    = "EastUS"
}

resource "azurerm_virtual_network" "vnet1" {
    name                = "NextOpsVNET01"
    resource_group_name = azurerm_resource_group.rg1.name
    location            = azurerm_resource_group.rg1.location
    address_space       = [ "10.0.0.0/16" ]  
}

resource "azurerm_subnet" "subnet1" {
    name                = "PublicSubnet01"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name 
    address_prefixes = [ "10.0.0.0/24" ]  
}

resource "azurerm_subnet" "subnet2" {
    name                = "PrivateSubnet01"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name 
    address_prefixes = [ "10.0.1.0/24" ]  
}

resource "azurerm_subnet" "subnet3" {
    name                = "PrivateSubnet02"
    resource_group_name = azurerm_resource_group.rg1.name
    virtual_network_name = azurerm_virtual_network.vnet1.name 
    address_prefixes = [ "10.0.2.0/24" ]  
}