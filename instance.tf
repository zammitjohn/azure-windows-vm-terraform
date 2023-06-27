resource "azurerm_virtual_machine" "win-vm" {
  name                             = "${var.prefix}-vm"
  location                         = var.location
  resource_group_name              = azurerm_resource_group.demo.name
  network_interface_ids            = [azurerm_network_interface.win-vm.id]
  vm_size                          = "Standard_DS1_v2"
  delete_data_disks_on_termination = true
  delete_os_disk_on_termination    = true

  storage_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-21h2-pro"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.hostname
    admin_username = var.username
    admin_password = var.password
    custom_data    = file("./files/winrm.ps1")
  }

  os_profile_windows_config {
    provision_vm_agent = true
    winrm {
      protocol = "HTTP"
    }
    # Auto-Login's required to configure WinRM
    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "AutoLogon"
      content      = "<AutoLogon><Password><Value>${var.password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.username}</Username></AutoLogon>"
    }

    # Unattend config is to enable basic auth in WinRM, required for the provisioner stage.
    additional_unattend_config {
      pass         = "oobeSystem"
      component    = "Microsoft-Windows-Shell-Setup"
      setting_name = "FirstLogonCommands"
      content      = file("./files/FirstLogonCommands.xml")
    }
  }
}

resource "azurerm_network_interface" "win-vm" {
  name                = "${var.prefix}-instance1"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name

  ip_configuration {
    name                          = "instance1"
    subnet_id                     = azurerm_subnet.demo-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win-vm.id
  }
}

resource "azurerm_network_interface_security_group_association" "win-vm" {
  network_interface_id      = azurerm_network_interface.win-vm.id
  network_security_group_id = azurerm_network_security_group.allow-remoting.id
}

resource "azurerm_public_ip" "win-vm" {
  name                = "instance1-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.demo.name
  allocation_method   = "Static"
}