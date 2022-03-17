resource "azurerm_resource_group" "this" {
  name     = "${var.project_name}ResourceGroup"
  location = var.location
}

resource "azurerm_management_group" "root" {
  display_name = "${var.project_name}ManagementGroup"

  subscription_ids = [
    data.azurerm_subscription.current.subscription_id
  ]
}