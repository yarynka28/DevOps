#Create resource group
resource "azurerm_resource_group" "grafana_resource_group" {
  name     = "grafana-resource-group"
  location = var.location
}

#Create network
resource "azurerm_virtual_network" "grafana_virtual_network" {
  name                = "grafana-virtual-network"
  address_space       = var.network_ip_address
  location            = var.location
  resource_group_name = azurerm_resource_group.grafana_resource_group.name
}

#Create subnet
resource "azurerm_subnet" "grafana_subnet" {
  name                 = "grafana-subnet"
  resource_group_name  = azurerm_resource_group.grafana_resource_group.name
  virtual_network_name = azurerm_virtual_network.grafana_virtual_network.name
  address_prefixes     = var.subnet_ip
}

#Create public ip
resource "azurerm_public_ip" "grafana_public_ip" {
  name                = "grafana-public-ip"
  location            = azurerm_resource_group.grafana_resource_group.location
  resource_group_name = azurerm_resource_group.grafana_resource_group.name
  allocation_method   = "Static"
}

#Create network interface
resource "azurerm_network_interface" "grafana_network" {
  name                = "grafana-network-interface"
  location            = azurerm_resource_group.grafana_resource_group.location
  resource_group_name = azurerm_resource_group.grafana_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.grafana_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.grafana_public_ip.id
  }
}

#Create network security group and rule
resource "azurerm_network_security_group" "grafana_network_security_group" {
  name                = "grafana-network-security-group"
  location            = azurerm_resource_group.grafana_resource_group.location
  resource_group_name = azurerm_resource_group.grafana_resource_group.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "connection" {
  network_interface_id      = azurerm_network_interface.grafana_network.id
  network_security_group_id = azurerm_network_security_group.grafana_network_security_group.id
}

#Create virtual machine
resource "azurerm_linux_virtual_machine" "grafana_vm" {
  name                  = "grafana-vm"
  resource_group_name   = azurerm_resource_group.grafana_resource_group.name
  location              = azurerm_resource_group.grafana_resource_group.location
  size                  = var.size
  admin_username        = "yaryna_28"
  custom_data           = filebase64(var.grafana)
  network_interface_ids = [
    azurerm_network_interface.grafana_network.id,
  ]

  admin_ssh_key {
    username   = "yaryna_28"
    public_key = file(var.ssh_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2" 
    version   = "latest"
  }
}
