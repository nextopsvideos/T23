# if you want to work with prod environment enter yes as value for env_prod when prompted
resource "azurerm_resource_group" "rg1" {
    name        = var.env_prod == "yes" ? "prod-rg" : "dev-rg"
    location    = var.env_prod == "yes" ? "westus" : "eastus"
}

resource "azurerm_virtual_network" "vnet" {
    name                =  var.env_prod == "yes" ? "prod-vnet" : "dev-vnet"  
    resource_group_name =  azurerm_resource_group.rg1.name
    location            =  azurerm_resource_group.rg1.location
    address_space       =  var.env_prod == "yes" ? ["10.20.0.0/16"] : ["10.10.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
    name                    = var.env_prod == "yes" ? "prod-subnet" : "dev-subnet"
    resource_group_name     = azurerm_resource_group.rg1.name
    virtual_network_name    = azurerm_virtual_network.vnet.name
    address_prefixes        = var.env_prod == "yes" ? ["10.20.0.0/24"] : ["10.10.0.0/24"]  
}
