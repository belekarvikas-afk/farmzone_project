resource "azurerm_public_ip" "public_ip" {
  for_each            = var.bastions
  name                = each.value.bastion_pip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_bastion_host" "bastion" {
  for_each            = var.bastions
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
 
  ip_configuration {
    name                 = each.value.ip_con_name
    subnet_id            = data.azurerm_subnet.subnet01[each.key].id
    public_ip_address_id = azurerm_public_ip.public_ip[each.key].id
  }
}