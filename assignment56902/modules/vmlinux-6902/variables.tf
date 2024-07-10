variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create resources."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where VMs will be deployed."
  type        = string
}

variable "storage_account_uri" {
  description = "URI of the storage account to be used for VM boot diagnostics."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VMs."
  type        = string
}

variable "public_key" {
  description = "Path to the public SSH key."
  type        = string
}

variable "private_key" {
  description = "Path to the private SSH key."
  type        = string
}

variable "linux_avs" {
  description = "The name of the availability set for Linux VMs."
  type        = string
}

variable "linux_vms" {
  description = "Map of Linux VM names and their attributes."
  type        = map(string)
}

