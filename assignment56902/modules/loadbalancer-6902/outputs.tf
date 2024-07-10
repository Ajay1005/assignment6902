output "load_balancer_name" {
  value = azurerm_lb.lb.name
}

output "load_balancer_pip" {
  value = azurerm_public_ip.lb_pip.ip_address
}
