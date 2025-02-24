variable "rg_name" {
  type = string
  description = "Resource Group Name"
}

variable "rg_location" {
  type = string
  description = "Resource Group Location"
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "subnet1_name" {
  type = string
}

variable "subnet2_name" {
  type = string
}

variable "subnet3_name" {
  type = string
}

variable "subnet1_aspace" {
  type = list(string)
}

variable "subnet2_aspace" {
  type = list(string)
}

variable "subnet3_aspace" {
  type = list(string)
}