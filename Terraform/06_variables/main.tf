resource "azurerm_resource_group" "myrg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_service_plan" "asp1" {
  name                = var.asp_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_resource_group.myrg.location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "app1" {
  name                = var.app_name
  resource_group_name = azurerm_resource_group.myrg.name
  location            = azurerm_service_plan.asp1.location
  service_plan_id     = azurerm_service_plan.asp1.id
  public_network_access_enabled = var.webapp_public_access

  site_config {}
}

resource "azurerm_virtual_network" "vnet1" {
  name                  = var.vnet_name
  resource_group_name   = azurerm_resource_group.myrg.name
  location              = azurerm_resource_group.myrg.location
  address_space         = var.vnet_address_space
}