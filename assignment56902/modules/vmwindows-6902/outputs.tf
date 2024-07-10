output "windows_vm_hostname" {
  value = azurerm_windows_virtual_machine.win_vm[*].name
}

output "windows_vm_fqdn" {
  value = azurerm_public_ip.win_vm_pip[*].fqdn
}

output "windows_private_ip" {
  value = azurerm_network_interface.win_vm_nic[*].private_ip_address
}

output "windows_public_ip" {
  value = azurerm_public_ip.win_vm_pip[*].ip_address
}

output "windows_availability_set_name" {
  value = azurerm_availability_set.windows_avset.name
}
output "vm_id" {
  value = azurerm_windows_virtual_machine.win_vm[*].id
}
