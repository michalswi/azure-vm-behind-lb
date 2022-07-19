
variable "name" {
  default = "demo"
}

variable "location" {
  default = "westeurope"
}

# https://docs.microsoft.com/en-us/azure/virtual-machines/sizes-b-series-burstable
variable "vm_size" {
  default = "Standard_B1s"
}

variable "public_ip" {
  description = "IP address allowed to ssh"
  type        = string
}
