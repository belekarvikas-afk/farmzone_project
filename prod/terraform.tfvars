resource_group = {
  rg01 = {
    name     = "Project007"
    location = "centralindia"
  }
}
virtual_network = {
  vnet01 = {
    name                = "Hub_vnet"
    resource_group_name = "Project007"
    location            = "centralindia"
    address_space       = ["10.0.0.0/16"]
  }
  vnet02 = {
    name                = "Spoke_vnet01"
    resource_group_name = "Project007"
    location            = "centralindia"
    address_space       = ["10.1.0.0/16"]
  }
  vnet03 = {
    name                = "Spoke_vnet02"
    resource_group_name = "Project007"
    location            = "westus2"
    address_space       = ["10.2.0.0/16"]
  }
  vnet04 = {
    name                = "Spoke_vnet03"
    resource_group_name = "Project007"
    location            = "centralindia"
    address_space       = ["10.3.0.0/16"]
  }
}
subnet = {
  subnet01 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "Project007"
    virtual_network_name = "Hub_vnet"
    address_prefixes     = ["10.0.1.0/26"]
  }
  subnet02 = {
    name                 = "ApplicationGatewaySubnet"
    resource_group_name  = "Project007"
    virtual_network_name = "Hub_vnet"
    address_prefixes     = ["10.0.2.0/27"]
  }
  subnet03 = {
    name                 = "AzureFirewallSubnet"
    resource_group_name  = "Project007"
    virtual_network_name = "Hub_vnet"
    address_prefixes     = ["10.0.3.0/26"]
  }
  subnet04 = {
    name                 = "Hub_subnet"
    resource_group_name  = "Project007"
    virtual_network_name = "Hub_vnet"
    address_prefixes     = ["10.0.4.0/24"]
  }
  subnet05 = {
    name                 = "Spoke01_subnet"
    resource_group_name  = "Project007"
    virtual_network_name = "Spoke_vnet01"
    address_prefixes     = ["10.1.1.0/24"]
  }
  subnet06 = {
    name                 = "Spoke02_subnet"
    resource_group_name  = "Project007"
    virtual_network_name = "Spoke_vnet02"
    address_prefixes     = ["10.2.1.0/24"]
  }
  subnet07 = {
    name                 = "Spoke03_subnet"
    resource_group_name  = "Project007"
    virtual_network_name = "Spoke_vnet03"
    address_prefixes     = ["10.3.1.0/24"]
  }
}
virtual_machine = {
  vm01 = {
    name                            = "VM01"
    nic_name                        = "nic01"
    subnet_name                     = "Spoke01_subnet"
    virtual_network_name            = "Spoke_vnet01"
    resource_group_name             = "Project007"
    location                        = "centralindia"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    admin_password                  = "Password@123"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "UbuntuServer"
    sku                             = "18.04-LTS"
    version                         = "latest"
    ip_vm_name                      = "ipconfig01"
    private_ip_address_allocation   = "Dynamic"
  }
  vm02 = {
    name                            = "VM02"
    nic_name                        = "nic02"
    subnet_name                     = "Spoke02_subnet"
    virtual_network_name            = "Spoke_vnet02"
    resource_group_name             = "Project007"
    location                        = "westus2"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    admin_password                  = "Password@123"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    ip_vm_name                      = "ipconfig02"
    private_ip_address_allocation   = "Dynamic"
  }
  vm03 = {
    name                            = "VM03"
    nic_name                        = "nic03"
    subnet_name                     = "Spoke03_subnet"
    virtual_network_name            = "Spoke_vnet03"
    resource_group_name             = "Project007"
    location                        = "centralindia"
    size                            = "Standard_D2s_v3"
    admin_username                  = "adminuser"
    admin_password                  = "Password@123"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"
    ip_vm_name                      = "ipconfig03"
    private_ip_address_allocation   = "Dynamic"
  }
}
NSG = {
  nsg01 = {
    name                                     = "nsg01"
    location                                 = "centralindia"
    resource_group_name                      = "Project007"
    security_rule_name                       = "AllowSSH"
    security_rule_priority                   = 222
    security_rule_direction                  = "Inbound"
    security_rule_access                     = "Allow"
    security_rule_protocol                   = "Tcp"
    security_rule_source_port_range          = "*"
    security_rule_destination_port_range     = "*"
    security_rule_source_address_prefix      = "*"
    security_rule_destination_address_prefix = "*"
  }
  nsg02 = {
    name                                     = "nsg02"
    location                                 = "eastus"
    resource_group_name                      = "Project007"
    security_rule_name                       = "AllowSSH"
    security_rule_priority                   = 233
    security_rule_direction                  = "Inbound"
    security_rule_access                     = "Allow"
    security_rule_protocol                   = "Tcp"
    security_rule_source_port_range          = "*"
    security_rule_destination_port_range     = "*"
    security_rule_source_address_prefix      = "*"
    security_rule_destination_address_prefix = "*"
  }
  nsg03 = {
    name                                     = "nsg03"
    location                                 = "canadacentral"
    resource_group_name                      = "Project007"
    security_rule_name                       = "AllowSSH"
    security_rule_priority                   = 244
    security_rule_direction                  = "Inbound"
    security_rule_access                     = "Allow"
    security_rule_protocol                   = "Tcp"
    security_rule_source_port_range          = "*"
    security_rule_destination_port_range     = "*"
    security_rule_source_address_prefix      = "*"
    security_rule_destination_address_prefix = "*"
  }
}
subnet_nsg_association = {
  subnet_nsg_association01 = {
    subnet_name          = "Spoke01_subnet"
    virtual_network_name = "Spoke_vnet01"
    resource_group_name  = "Project007"
    name                 = "nsg01"
  }
  subnet_nsg_association02 = {
    subnet_name          = "Spoke02_subnet"
    virtual_network_name = "Spoke_vnet02"
    resource_group_name  = "Project007"
    name                 = "nsg02"
  }
  subnet_nsg_association03 = {
    subnet_name          = "Spoke03_subnet"
    virtual_network_name = "Spoke_vnet03"
    resource_group_name  = "Project007"
    name                 = "nsg03"
  }
}
firewall = {
  firewall01 = {
    name                  = "firewall01"
    firewall_pip_name     = "firewall_public_ip02"
    location              = "centralindia"
    resource_group_name   = "Project007"
    virtual_network_name  = "Hub_vnet"
    subnet_name           = "AzureFirewallSubnet"
    sku_name              = "AZFW_VNet"
    sku_tier              = "Standard"
    ip_configuration_name = "ipconfig01"
    allocation_method     = "Static"
    pip_sku               = "Standard"
  }
}
bastion = {
  bastion01 = {
    bastion_name         = "bastion01"
    bastion_pip_name     = "bastion_public_ip01"
    location             = "centralindia"
    resource_group_name  = "Project007"
    virtual_network_name = "Hub_vnet"
    subnet_name          = "AzureBastionSubnet"
    ip_con_name          = "ipconfig01"
    allocation_method    = "Static"
    sku                  = "Standard"
  }
}
