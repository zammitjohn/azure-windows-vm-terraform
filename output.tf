output "demo_instance_public_ip" {
  description = "The actual ip address allocated for the resource."
  value       = azurerm_public_ip.win-vm.ip_address
}