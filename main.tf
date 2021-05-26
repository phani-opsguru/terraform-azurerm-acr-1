#---------------------------------------------------------
# Local Declarations
#---------------------------------------------------------
locals {
  resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)
  location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0)
  roles_map           = { for role in var.roles : "${role.ppal_id}.${role.role}" => role }
}

#---------------------------------------------------------
# Data
#---------------------------------------------------------
data "azurerm_client_config" "current" {}


#---------------------------------------------------------
# Resources
#---------------------------------------------------------

data "azurerm_resource_group" "rgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}

resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = lower(var.resource_group_name)
  location = var.location
  tags     = merge({ "ResourceName" = format("%s", var.resource_group_name) }, var.tags, )
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = local.resource_group_name
  location            = local.location
  sku                 = var.acr_sku
  admin_enabled       = var.admin_enabled
  trust_policy {
    enabled = var.content_trust
  }

}


/* Phase 2 */
/* resource "azurerm_role_assignment" "roles" {
  for_each = local.roles_map

  scope                = azurerm_container_registry.acr.id
  role_definition_name = each.value.role
  principal_id         = each.value.ppal_id

} */