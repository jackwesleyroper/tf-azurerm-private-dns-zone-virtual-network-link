data "azurerm_virtual_network" "target_vnet" {
  for_each            = var.virtual_networks
  provider            = azurerm.target_sub
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnet_link" {
  for_each              = var.virtual_networks
  name                  = "${each.value.name}-vnet-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = var.private_dns_zone_name
  virtual_network_id    = data.azurerm_virtual_network.target_vnet[each.key].id
  registration_enabled  = each.value.registration_enabled
  tags                  = var.tags

}
