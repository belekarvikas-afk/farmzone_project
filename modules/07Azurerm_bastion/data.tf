data "azurerm_subnet" "subnet01" {
  for_each             = var.bastions
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name

}