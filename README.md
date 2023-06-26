# azure-windows-vm-terraform

This is a practice project which deploys a new Windows 11 VM on Azure, opens RDP and WinRM ports and outputs the public IP using Terraform.

## Prerequisites

- Terraform installed on your machine
- Azure CLI installed on your machine

## How to use

1. Clone the repository
2. Run `az login` to log in to your Azure account
3. Run `terraform fmt` to format the code
4. Run `terraform init` to initialize the project
5. Run `terraform apply -auto-approve` to deploy the VM
6. Run `terraform output demo_instance_public_ip` to get the public IP of the VM
7. To destroy the VM, run `terraform destroy -auto-approve`

## Connect using WinRM

1. Use command `winrm set winrm/config/client '@{TrustedHosts="<VM IP Address>"}'` to add the VM IP to the TrustedHosts list for WinRM client
2. Use command `Get-Credential | Export-Clixml "mycredentials.xml"` to create the credentials, entering the VM username and password
3. Use command `Enter-PSSession -computername <VM IP Address> -credential (Import-Clixml "mycredentials.xml")` to create an interactive PowerShell session to the VM