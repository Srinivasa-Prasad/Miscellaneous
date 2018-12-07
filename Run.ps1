## Download Latest Docker Installer (Windows) from Docker Website.
"$(Get-Date) - Information - Initiating Docker For Windows Installer Download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://download.docker.com/win/stable/Docker for Windows Installer.exe' -OutFile 'C:\Docker for Windows Installer.exe'
"$(Get-Date) - Information - Download Completed."| Out-File C:\Configure.log -Append

## Install Hyper-V Feature required for Docker Installation.
"$(Get-Date) - Information - Initiating Hyper-V Feature installation."| Out-File C:\Configure.log -Append
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart
