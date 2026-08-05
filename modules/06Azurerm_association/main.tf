resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  for_each                  = var.subnet_nsg_association
  subnet_id                 = data.azurerm_subnet.subnet[each.key].id
  network_security_group_id = data.azurerm_network_security_group.nsg001[each.key].id
}