resource "azurerm_resource_group" "rgname" {
  name     = "nextopsrg08"
  location = "EastUS"

  lifecycle {
    prevent_destroy = true
  }
  
}

resource "azurerm_virtual_network" "nextopsvnet04" {
  name                  = "NextOpsVNET09"
  resource_group_name   = azurerm_resource_group.rgname.name
  location              = azurerm_resource_group.rgname.location
  address_space         = ["10.4.0.0/16"]  

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_subnet" "subnet1" {
    name = "Subnet1"
    resource_group_name = azurerm_resource_group.rgname.name
    virtual_network_name = azurerm_virtual_network.nextopsvnet04.name 
    address_prefixes = [ "10.4.0.0/24" ]
}