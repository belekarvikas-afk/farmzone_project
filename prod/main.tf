module "rg" {
  source = "../../modules/01Azurerm_resource_group"
  rgs    = var.resource_group
}
module "vnet" {
  source     = "../../modules/02Azurerm_virtual_network"
  vnets      = var.virtual_network
  depends_on = [module.rg]
}
module "subnet" {
  source     = "../../modules/03Azurerm_subnet"
  subnets    = var.subnet
  depends_on = [module.vnet]
}

module "virtual_machine" {
  source     = "../../modules/04Azurerm_virtual_machine"
  linux_vms  = var.virtual_machine
  depends_on = [module.subnet]
}
module "nsg" {
  source     = "../../modules/05Azurerm_network_security_group"
  nsgs       = var.NSG
  depends_on = [module.subnet, module.rg]
}

module "subnet_nsg_association" {
  source                 = "../../modules/06Azurerm_association"
  subnet_nsg_association = var.subnet_nsg_association
  depends_on             = [module.rg]
}

module "bastion" {
  source     = "../../modules/07Azurerm_bastion"
  bastions   = var.bastion
  depends_on = [module.subnet, module.rg]
}

module "firewall" {
  source     = "../../modules/09Azurerm_firewall"
  firewall   = var.firewall
  depends_on = [module.subnet, module.rg]
}

