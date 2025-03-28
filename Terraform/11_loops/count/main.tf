resource "azurerm_resource_group" "myrg" {
    name     = var.rg_name
    location = var.rg_location
}

resource "azurerm_virtual_network" "myvnet" {
    name                = var.vnet_name
    resource_group_name = azurerm_resource_group.myrg.name
    location            = azurerm_resource_group.myrg.location
    address_space       = var.address_space

    depends_on = [ azurerm_resource_group.myrg ]
}

resource "azurerm_subnet" "subnet" {
    count               = length(var.subnet_name) #4
    name                = var.subnet_name[count.index] # subnet_name[0]= subnet1, subnet_name[1] = subnet2
    resource_group_name = azurerm_resource_group.myrg.name
    virtual_network_name = azurerm_virtual_network.myvnet.name
    address_prefixes    = [ "10.10.${count.index}.0/24" ]

    depends_on = [ azurerm_resource_group.myrg,
                   azurerm_virtual_network.myvnet 
                 ]        
}


resource "azurerm_network_interface" "nic" {
    count               = 4
    name                = "nextopsvm-${count.index}-nic" #nextopsvm-0-nic, nextopsvm-1-nic
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name 

   ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet[count.index].id
    private_ip_address_allocation = "Dynamic"
  }

    depends_on = [ azurerm_subnet.subnet ]
}


resource "azurerm_linux_virtual_machine" "vm" {
    count               = 4
    name                = "nextopsvm-${count.index}"
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name
    size                = "standard_B1s"
    admin_username      = "adminuser"
    network_interface_ids = [
        azurerm_network_interface.nic[count.index].id
    ]

    admin_ssh_key {
        username   = "adminuser"
        #ssh-keygen -t rsa -f C:\Terraform\SSHKeys\06022025\id_rsa  <--- command to generate ssk keys in windows
        public_key = file("C:/Class_Code/t23/Terraform/11_loops/count/SSH_Keys/id_rsa.pub")
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    } 

    depends_on = [ 
        azurerm_resource_group.myrg,
        azurerm_virtual_network.myvnet,
        azurerm_subnet.subnet,
        azurerm_network_interface.nic
     ] 
}