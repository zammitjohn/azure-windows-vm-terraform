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