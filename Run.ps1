## Install Hyper-V Feature required for Docker Installation.
"$(Get-Date) - Information - Initiating Hyper-V Feature installation."| Out-File C:\Configure.log -Append
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
"$(Get-Date) - Information - Hyper-V Feature installation completed."| Out-File C:\Configure.log -Append

## Download Docker for Windows.
"$(Get-Date) - Information - Initiating Docker For Windows Installer download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://download.docker.com/win/stable/Docker for Windows Installer.exe' -OutFile 'C:\Docker for Windows Installer.exe'
"$(Get-Date) - Information - Docker for Windows download completed."| Out-File C:\Configure.log -Append

## Download Latest Visual Studio Code Installer.
"$(Get-Date) - Information - Initiating Visual Studio Code Download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://srinivasablobstorage.file.core.windows.net/downloads/VSCodeSetup-x64-1.29.1.exe?st=2018-12-10T04%3A04%3A40Z&se=2020-01-01T04%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=HcgbJvJkyCkrdRWSw57cZdgtkG40u70tt92EHyux374%3D' -OutFile 'C:\VSCodeSetup.exe'
"$(Get-Date) - Information - Visual Studio Code Download Completed."| Out-File C:\Configure.log -Append

## Download Latest Git Installer.
"$(Get-Date) - Information - Initiating Git Download."| Out-File C:\Configure.log -Append
Invoke-WebRequest 'https://srinivasablobstorage.file.core.windows.net/downloads/Git-2.19.1-64-bit.exe?st=2018-12-11T23%3A42%3A12Z&se=2020-12-30T23%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=NIGD9JpQw1U2L5GbTSHoFGpEs4jg8Fzwhgg7kvxDHE8%3D' -OutFile 'C:\Git.exe'
"$(Get-Date) - Information - Git Download Completed."| Out-File C:\Configure.log -Append

## Docker for Windows Installation. 
"$(Get-Date) - Information - Initiating Docker Installation."| Out-File C:\Configure.log -Append
$EXE = "C:\Docker for Windows Installer.exe"
$Arguments = "install --quiet"
    
Start-Process $EXE $Arguments -Wait
    
"$(Get-Date) - Information - Completed Docker Installation.."| Out-File C:\Configure.log -Append

## Visual Studio Code Installation. 
"$(Get-Date) - Information - Initiating Visual Studio Code Installation."| Out-File C:\Configure.log -Append
$EXE = "C:\VSCodeSetup.exe"
$Arguments = "/VERYSILENT /MERGETASKS=!runcode"
    
Start-Process $EXE $Arguments -Wait
    
"$(Get-Date) - Information - Completed Visual Studio Code Installation.."| Out-File C:\Configure.log -Append

## Git Installation.
"$(Get-Date) - Information - Initiating Git Installation."| Out-File C:\Configure.log -Append
$EXE = "C:\Git.exe"
$Arguments = '/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"'

Start-Process $EXE $Arguments -Wait
    
"$(Get-Date) - Information - Completed Git Installation.."| Out-File C:\Configure.log -Append

## Download AzureRm PowerShell Modules.
Install-Package AzureRm -AllowClobber -Force -Confirm:$False

## Finally after all configuration. Restart Computer.
## CustomScriptExtension shouldn't be used for restarting computer. However this script is verified and tested OK.
Restart-Computer -Force
