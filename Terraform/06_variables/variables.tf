variable "rg_name" {
  type = string
  description = "Resource Group Name"
  default = "NextOpsRG23"
}

variable "rg_location" {
  type = string
  description = "Resource Group Location"
}

variable "asp_name" {
  type = string
}

variable "app_name" {
  type = string  
}

variable "os_type" {
  type = string  
}

variable "sku_name" {
  type = string  
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "webapp_public_access" {
  type = bool  
}