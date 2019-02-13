variable "name" {
  type        = "string"
  description = "Name of this cluster."
  default     = "pseskubedemo"
}

variable "client_id" {
  type        = "string"
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = "string"
  description = "Client secret"
}

variable "resource_group_name" {
  type        = "string"
  description = "Name of the azure resource group."
  default     = "pseskubedemo"
}

variable "resource_group_location" {
  type        = "string"
  description = "Location of the azure resource group."
  default     = "eastus2"
}

variable "linux_admin_username" {
  type        = "string"
  description = "User name for authentication to the Kubernetes linux agent virtual machines in the cluster"
  default     = "psadmin"
}

variable "linux_admin_ssh_publickey_path" {
  type        = "string"
  description = "Configure all the linux virtual machines in the cluster with the SSH RSA public key string at the specified path"
}
