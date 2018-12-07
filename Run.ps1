## Download Latest Docker Installer (Windows) from Docker Website.
"$(Get-Date) - Information - Initiating Docker For Windows Installer Download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://download.docker.com/win/stable/Docker for Windows Installer.exe' -OutFile 'C:\Docker for Windows Installer.exe'
"$(Get-Date) - Information - Download Completed."| Out-File C:\Configure.log -Append

## Install Hyper-V Feature required for Docker Installation.
"$(Get-Date) - Information - Initiating Hyper-V Feature installation."| Out-File C:\Configure.log -Append
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
"$(Get-Date) - Information - Download Completed."| Out-File C:\Configure.log -Append

## Install Docker for Windows
"$(Get-Date) - Information - Initiating Docker for Windows installation."| Out-File C:\Configure.log -Append
"C:\Docker for Windows Installer.exe" install --quiet
"$(Get-Date) - Information - Docker for Windows installation completed."| Out-File C:\Configure.log -Append

## Finally after all configuration. Restart Computer.
## CustomScriptExtension shouldn't be used for restarting computer. However this script is verified and tested OK.
Restart-Computer -Force
