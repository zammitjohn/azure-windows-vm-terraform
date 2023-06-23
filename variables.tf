variable "location" {
  type = string
}

variable "prefix" {
  type    = string
  default = "practice-jz"
}

variable "rdp-source-address" {
  type    = string
  default = "*"
}

variable "username" {
  default = "labadmin"
  description = "Admin username for the VM"
}

variable "password" {
  default = "P@ssw0rd1234!"
  description = "Admin password for the VM"
}

variable "hostname" {
  default = "win"
  description = "Specify the VM hostname"
}