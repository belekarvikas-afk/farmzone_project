resource "azurerm_resource_group" "rgs"{
    name = "vikas-rg"
    location = "westus"
}

resource "azurerm_virtual_network" "vnet" {
    name = "vikas-vnet"
    resource_group_name = azurerm_resource_group.rgs.name
    location = azurerm_resource_group.rgs.location
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet1" {
    name = "frontend1-subnet1"
    resource_group_name = azurerm_resource_group.rgs.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.1.0/24"]
}
resource "azurerm_subnet" "subnet2" {
    name = "AzureBastionSubnet"
    resource_group_name = azurerm_resource_group.rgs.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.2.0/26"]
}
resource "azurerm_subnet" "subnet3" {
    name = "ApplicationGatewaySubnet"
    resource_group_name = azurerm_resource_group.rgs.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.3.0/24"]
}
resource "azurerm_subnet" "subnet4" {
    name = "frontend2-subnet4"
    resource_group_name = azurerm_resource_group.rgs.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.4.0/24"]
}

resource "azurerm_public_ip" "pip1" {
    name = "bastion-pip"
    resource_group_name = azurerm_resource_group.rgs.name
    location = azurerm_resource_group.rgs.location
    allocation_method = "Static"
    sku = "Standard"
}
resource "azurerm_public_ip" "pip2" {
    name = "application-gateway-pip"
    resource_group_name = azurerm_resource_group.rgs.name
    location = azurerm_resource_group.rgs.location
    allocation_method = "Static"
    
}

resource "azurerm_linux_virtual_machine" "vm1" {
    name = "strimfilx-vm1"
    resource_group_name = azurerm_resource_group.rgs.name
    location = azurerm_resource_group.rgs.location
    size = "Standard_D2s_v3"
    admin_username = "admin01"
    admin_password = "Password@123"
    disable_password_authentication = false
    network_interface_ids = [azurerm_network_interface.nic1.id]
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}
resource "azurerm_linux_virtual_machine" "vm2" {
    name = "starbucks-vm2"
    resource_group_name = azurerm_resource_group.rgs.name
    location = azurerm_resource_group.rgs.location
    size = "Standard_D2s_v3"
    admin_username = "admin01"
    admin_password = "Password@123"
    disable_password_authentication = false
    network_interface_ids = [azurerm_network_interface.nic2.id]
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}

resource "azurerm_network_interface" "nic1" {
    name                = "vikas-nic1"
    location            = azurerm_resource_group.rgs.location
    resource_group_name = azurerm_resource_group.rgs.name
    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet1.id
        private_ip_address_allocation = "Dynamic"
    }
}
resource "azurerm_network_interface" "nic2" {
    name                = "vikas-nic2"
    location            = azurerm_resource_group.rgs.location
    resource_group_name = azurerm_resource_group.rgs.name
    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet4.id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_security_group" "nsg1" {
    name                = "vikas-nsg1"
    location            = azurerm_resource_group.rgs.location
    resource_group_name = azurerm_resource_group.rgs.name
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["22"]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
resource "azurerm_network_security_group" "nsg2" {
    name                = "vikas-nsg1"
    location            = azurerm_resource_group.rgs.location
    resource_group_name = azurerm_resource_group.rgs.name
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["80"]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
resource "azurerm_network_security_group" "nsg3" {
    name                = "vikas-nsg2"
    location            = azurerm_resource_group.rgs.location
    resource_group_name = azurerm_resource_group.rgs.name
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["22"]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}
resource "azurerm_network_security_group" "nsg4" {
    name                = "vikas-nsg2"
    location            = azurerm_resource_group.rgs.location
    resource_group_name = azurerm_resource_group.rgs.name
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_ranges    = ["80"]
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_association" "nsg_association1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}
resource "azurerm_association" "nsg_association2" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg2.id
}
resource "azurerm_association" "nsg_association3" {
  subnet_id                 = azurerm_subnet.subnet4.id
  network_security_group_id = azurerm_network_security_group.nsg3.id
}
resource "azurerm_association" "nsg_association4" {
  subnet_id                 = azurerm_subnet.subnet4.id
  network_security_group_id = azurerm_network_security_group.nsg4.id
}

resource "azurerm_bastion_host" "bastion" {
    name                = "vikas-bastion"
    resource_group_name = azurerm_resource_group.rgs.name
    location            = azurerm_resource_group.rgs.location
    
    ip_configuration {
        name                 = "configuration"
        subnet_id            = azurerm_subnet.subnet2.id
        public_ip_address_id = azurerm_public_ip.pip1.id
    }
}

locals {
  backend_address_pool_name      = "backend_pool"
  frontend_port_name             = "frontend_port"
  frontend_ip_configuration_name = "frontend_ipconfig"
  http_setting_name              = "settings01"
  listener_name                  = "vikas-listener"
  request_routing_rule_name      = "rout_rule1"
  redirect_configuration_name    = "redirect_config"
}
resource "azurerm_application_gateway" "appgw" {
  name                = "vikasappgateway"
  resource_group_name = azurerm_resource_group.rgs.name
  location            = azurerm_resource_group.rgs.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = azurerm_subnet.subnet3.id
  }
  frontend_port {
    name = local.frontend_port_name
    port = 80
  }
  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pip2.id
  }
  backend_address_pool {
    name = local.backend_address_pool_name
  }
  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }
  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }
  request_routing_rule {
    name                       = local.request_routing_rule_name
    priority                   = 100
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}

