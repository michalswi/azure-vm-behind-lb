
output "lb_pip" {
  value = azurerm_public_ip.pip.ip_address
}

output "ssh_username" {
  value = azurerm_linux_virtual_machine.main.admin_username
}
