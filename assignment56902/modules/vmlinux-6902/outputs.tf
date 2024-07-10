output "vm_hostnames" {
  value = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.computer_name]
}

output "vm_fqdns" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.domain_name_label]
}

output "private_ip_addresses" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.private_ip_address]
}

output "public_ip_addresses" {
  value = [for pip in azurerm_public_ip.linux_pip : pip.ip_address]
}

output "vm_ids" {
  description = "List of Linux VM IDs"
  value       = [for vm in azurerm_linux_virtual_machine.linux_vm : vm.id]
}
output "linux_availability_set_name" {
  description = "Name of the Linux availability set"
  value = azurerm_availability_set.linux_availability_set.name
}
output "nic_ids" {
  value = [for nic in azurerm_network_interface.linux_nic : nic.id]
}
