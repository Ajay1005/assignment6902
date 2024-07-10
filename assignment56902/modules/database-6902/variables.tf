variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "db_username" {
  description = "The administrator username for the PostgreSQL server"
  type        = string
}

variable "db_password" {
  description = "The administrator password for the PostgreSQL server"
  type        = string
}
