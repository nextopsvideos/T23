resource "azurerm_resource_group" "myrg" {
  name     = "TFRG"
  location = "EastUS"
}

resource "azurerm_virtual_network" "myvnet" {
  name                  = "TFVNET"
  resource_group_name   = azurerm_resource_group.myrg.name
  location              = azurerm_resource_group.myrg.location
  address_space         = [ "10.10.0.0/16" ] #65,536 ips
}

resource "azurerm_subnet" "subnet1" {
  name                  = "Subnet01"
  resource_group_name   = azurerm_resource_group.myrg.name 
  virtual_network_name  = azurerm_virtual_network.myvnet.name 
  address_prefixes      = [ "10.10.0.0/24" ] #256 ips
}

resource "azurerm_subnet" "subnet2" {
  name                  = "Subnet02"
  resource_group_name   = azurerm_resource_group.myrg.name 
  virtual_network_name  = azurerm_virtual_network.myvnet.name 
  address_prefixes      = [ "10.10.1.0/24" ] #256 ips
}

resource "azurerm_subnet" "subnet3" {
  name                  = "Subnet03"
  resource_group_name   = azurerm_resource_group.myrg.name 
  virtual_network_name  = azurerm_virtual_network.myvnet.name 
  address_prefixes      = [ "10.10.2.0/24" ] #256 ips
}

resource "azurerm_subnet" "subnet4" {
  name                  = "Subnet04"
  resource_group_name   = azurerm_resource_group.myrg.name 
  virtual_network_name  = azurerm_virtual_network.myvnet.name 
  address_prefixes      = [ "10.10.3.0/24" ] #256 ips
}