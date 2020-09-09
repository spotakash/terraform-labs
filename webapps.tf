
resource "random_string" "webapprnd" {
  length  = 8
  lower   = true
  number  = true
  upper   = false
  special = false
}

resource "azurerm_app_service_plan" "free" {
  name                = "plan-free-${var.loc}"
  location            = var.loc
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
  name                = "webapp-${random_string.webapprnd.result}-${var.loc}"
  location            = var.loc
  resource_group_name = azurerm_resource_group.nsgs.name
  tags                = azurerm_resource_group.nsgs.tags

  app_service_plan_id = azurerm_app_service_plan.free.id
}