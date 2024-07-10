variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "linux_nic_ids" {
  description = "List of Linux VM NIC IDs"
  type        = list(string)
}
