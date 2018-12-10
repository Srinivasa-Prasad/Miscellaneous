## Download Latest Docker Installer (Windows) from Docker Website.
"$(Get-Date) - Information - Initiating Docker For Windows Installer Download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://download.docker.com/win/stable/Docker for Windows Installer.exe' -OutFile 'C:\Docker for Windows Installer.exe'
"$(Get-Date) - Information - Docker For Windows Download Completed."| Out-File C:\Configure.log -Append

"$(Get-Date) - Information - Initiating Visual Studio Code Download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://srinivasablobstorage.file.core.windows.net/downloads/VSCodeSetup-x64-1.29.1.exe?st=2018-12-10T04%3A04%3A40Z&se=2020-01-01T04%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=HcgbJvJkyCkrdRWSw57cZdgtkG40u70tt92EHyux374%3D' -OutFile 'C:\VSCodeSetup-x64-1.29.1.exe'
"$(Get-Date) - Information - Visual Studio Code Download Completed."| Out-File C:\Configure.log -Append

## Install Hyper-V Feature required for Docker Installation.
"$(Get-Date) - Information - Initiating Hyper-V Feature installation."| Out-File C:\Configure.log -Append
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
"$(Get-Date) - Information - Download Completed."| Out-File C:\Configure.log -Append

## Finally after all configuration. Restart Computer.
## CustomScriptExtension shouldn't be used for restarting computer. However this script is verified and tested OK.
Restart-Computer -Force
