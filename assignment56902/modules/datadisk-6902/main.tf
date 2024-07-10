# modules/datadisk-n01656902/main.tf

resource "azurerm_managed_disk" "data_disk" {
  count                = 4
  name                 = "n01656902-datadisk-${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_disk_attach" {
  count              = 3
  managed_disk_id    = azurerm_managed_disk.data_disk[count.index].id
  virtual_machine_id = var.linux_vm_ids[count.index]
  lun                = 0
  caching            = "ReadWrite"
}

resource "azurerm_virtual_machine_data_disk_attachment" "windows_disk_attach" {
  managed_disk_id    = azurerm_managed_disk.data_disk[3].id
  virtual_machine_id = var.windows_vm_id
  lun                = 0
  caching            = "ReadWrite"
}

