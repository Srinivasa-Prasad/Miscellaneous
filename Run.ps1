## Download Latest Docker Installer (Windows) from Docker Website.
"$(Get-Date) - Information - Initiating Docker For Windows Installer Download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://download.docker.com/win/stable/Docker for Windows Installer.exe' -OutFile 'C:\Docker for Windows Installer.exe'
