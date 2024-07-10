
resource "azurerm_windows_virtual_machine" "win_vm" {
  count               = 1
  name                = "n01656902-w-vm${count.index + 1}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  availability_set_id = azurerm_availability_set.windows_avset.id
  network_interface_ids = [
    azurerm_network_interface.win_vm_nic[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }
}

resource "azurerm_network_interface" "win_vm_nic" {
  count               = 1
  name                = "n01656902-w-vm${count.index + 1}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_vm_pip[count.index].id
  }
}

resource "azurerm_public_ip" "win_vm_pip" {
  count               = 1
  name                = "n01656902-w-vm${count.index + 1}-pip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "n01656902-w-vm${count.index + 1}"
}

resource "azurerm_availability_set" "windows_avset" {
  name                = var.windows_avs
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count                = 1
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.win_vm[count.index].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true
    }
SETTINGS
}
