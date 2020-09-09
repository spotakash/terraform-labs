
resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

// Susbcription offer may limit the number of free Linux app service plans to one
// If either switch to different kind = "Windows" or sku.tier = "Standard", sku.size = "S1"

resource "azurerm_app_service_plan" "free" {
  count               = length(var.webapplocs)
  name                = "plan-free-${var.webapplocs[count.index]}"
  location            = var.webapplocs[count.index]
  resource_group_name = azurerm_resource_group.nsgs.name
  tags                = azurerm_resource_group.nsgs.tags

  kind     = "Linux"
  reserved = true
  sku {
    tier = "Free"
    size = "F1"
  }
}

resource "azurerm_app_service" "akapsvc" {
  count               = length(var.webapplocs) * local.webappsperlocation
  name                = format("webapp-%s-%02d-%s", random_string.webapprnd.result, count.index + 1, element(var.webapplocs, count.index))
  location            = element(var.webapplocs, count.index)
  resource_group_name = azurerm_resource_group.nsgs.name
  tags                = azurerm_resource_group.nsgs.tags

  app_service_plan_id = element(azurerm_app_service_plan.free.*.id, count.index)
}

locals {
  webappsperlocation = 3
}

output "webapp_ids" {
  description = "ids of the webapp provisioned"
  value       = [azurerm_app_service.akapsvc.*.id]
}