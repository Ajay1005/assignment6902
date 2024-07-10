variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "linux_vm_ids" {
  description = "List of Linux VM IDs"
  type        = list(string)
}

variable "windows_vm_id" {
  description = "Windows VM ID"
  type        = string
}
