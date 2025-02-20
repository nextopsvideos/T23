data "azurerm_resource_group" "existing_rg" {
    name = "DevRG"  
}

data "azurerm_virtual_network" "existing_vnet" {
    name = "DevVNET01"
    resource_group_name = data.azurerm_resource_group.existing_rg.name  
}

resource "azurerm_subnet" "new_subnet1" {
    name            = "TFSubnet01"
    resource_group_name = data.azurerm_resource_group.existing_rg.name 
    virtual_network_name = data.azurerm_virtual_network.existing_vnet.name 
    address_prefixes = ["10.10.0.0/24"]  
}

resource "azurerm_subnet" "new_subnet2" {
    name            = "TFSubnet02"
    resource_group_name = data.azurerm_resource_group.existing_rg.name 
    virtual_network_name = data.azurerm_virtual_network.existing_vnet.name 
    address_prefixes = ["10.10.1.0/24"]  
}

resource "azurerm_public_ip" "new_pip" {
    name                    = "DevVMPIP01"
    resource_group_name     = data.azurerm_resource_group.existing_rg.name 
    location                = data.azurerm_resource_group.existing_rg.location
    allocation_method       = "Static"
}

resource "azurerm_network_interface" "new_nic" {
  name                = "DevVMNic01"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name 

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.new_subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.new_pip.id
  }
}

resource "azurerm_network_security_group" "new_nsg" {
    name                         = "DevNSG01"
    location            = data.azurerm_resource_group.existing_rg.location
    resource_group_name = data.azurerm_resource_group.existing_rg.name 
}

resource "azurerm_network_security_rule" "new_rule" {
    name                        = "Allow_RDP"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = data.azurerm_resource_group.existing_rg.name 
    network_security_group_name = azurerm_network_security_group.new_nsg.name
}

resource "azurerm_network_interface_security_group_association" "nsgassoc1" {
    network_security_group_id = azurerm_network_security_group.new_nsg.id 
    network_interface_id = azurerm_network_interface.new_nic.id
}

resource "azurerm_windows_virtual_machine" "new_vm" {
  name                = "DevVM01"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name 
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.new_nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  lifecycle {
    ignore_changes = [ vm_agent_platform_updates_enabled ]
  }
}