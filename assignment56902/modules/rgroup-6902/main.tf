resource "azurerm_resource_group" "n01656902-RG" {
  name     = "${var.resource_group_name}-RG"
  location = var.location
}
