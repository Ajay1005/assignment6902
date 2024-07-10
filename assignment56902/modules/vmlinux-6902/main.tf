resource "azurerm_availability_set" "linux_availability_set" {
  name                = var.linux_avs
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed             = true
}

resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.linux_vms
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "tf-${each.key}"
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.linux_vms
  name                = "linux-nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.linux_pip[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each            = var.linux_vms
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]
  availability_set_id = azurerm_availability_set.linux_availability_set.id

  size             = "Standard_B1ms"

  os_disk {
    name              = "linux-os-disk-${each.key}"
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  
  computer_name  = each.key
  admin_username = var.admin_username

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key)
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = {
    Assignment    = "CCGC 5502 Automation Assignment"
    Name          = "ajay.uthirapathy"
    ExpirationDate = "2024-12-31"
    Environment   = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "linux_network_watcher" {
  for_each               = var.linux_vms
  name                  = "networkWatcherAgentLinux-${each.key}"
  virtual_machine_id    = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher             = "Microsoft.Azure.NetworkWatcher"
  type                  = "NetworkWatcherAgentLinux"
  type_handler_version  = "1.4"
}

resource "azurerm_virtual_machine_extension" "linux_monitor" {
  for_each               = var.linux_vms
  name                  = "azureMonitorLinuxAgent-${each.key}"
  virtual_machine_id    = azurerm_linux_virtual_machine.linux_vm[each.key].id
  publisher             = "Microsoft.Azure.Monitor"
  type                  = "AzureMonitorLinuxAgent"
  type_handler_version  = "1.25"
}

