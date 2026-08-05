resource "azurerm_public_ip" "public_ip" {
  for_each            = var.firewall
  name                = each.value.firewall_pip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.pip_sku
}

resource "azurerm_firewall" "firewall" {
  for_each            = var.firewall
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier

  ip_configuration {
    name                 = each.value.ip_configuration_name
    subnet_id            = data.azurerm_subnet.subnet[each.key].id
    public_ip_address_id = azurerm_public_ip.public_ip[each.key].id
  }
}