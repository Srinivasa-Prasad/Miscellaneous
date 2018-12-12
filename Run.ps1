Function Download-WebInstallerFile([String] $FileTitle, [String] $SourceFile, [String] $DestinationFile){
    "$(Get-Date) - Information - Initiating $FileTitle Download."| Out-File C:\Configure.log -Append
    Invoke-WebRequest $SourceFile -OutFile $DestinationFile
    "$(Get-Date) - Information - Completed $FileTitle Download."| Out-File C:\Configure.log -Append
}

Function Execute-InstallationCommand([String] $CommandTitle, [String] $CommandPath, [String] $CommandArguments){
    "$(Get-Date) - Information - Initiating $CommandTitle Installation."| Out-File C:\Configure.log -Append
    Start-Process $CommandPath $CommandArguments -Wait
    "$(Get-Date) - Information - Completed $CommandTitle Installation."| Out-File C:\Configure.log -Append
}

## Install Hyper-V Feature required for Docker Installation.
"$(Get-Date) - Information - Initiating Hyper-V Feature installation."| Out-File C:\Configure.log -Append
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
"$(Get-Date) - Information - Hyper-V Feature installation completed."| Out-File C:\Configure.log -Append

## Download Installer Files.
Download-WebInstallerFile -FileTitle 'Docker for Windows (Docker Website)' -DestinationFile 'C:\Docker for Windows Installer.exe' -SourceFile 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
Download-WebInstallerFile -FileTitle 'Visual Studio Code (Blob)' -DestinationFile 'C:\VSCodeSetup.exe' -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/VSCodeSetup-x64-1.29.1.exe?st=2018-12-10T04%3A04%3A40Z&se=2020-01-01T04%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=HcgbJvJkyCkrdRWSw57cZdgtkG40u70tt92EHyux374%3D'
Download-WebInstallerFile -FileTitle 'Git (Blob)' -DestinationFile 'C:\Git.exe' -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/Git-2.19.1-64-bit.exe?st=2018-12-11T23%3A42%3A12Z&se=2020-12-30T23%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=NIGD9JpQw1U2L5GbTSHoFGpEs4jg8Fzwhgg7kvxDHE8%3D'
Download-WebInstallerFile -FileTitle 'Visual Studio Code - PowerShell Extension (Blob)' -DestinationFile -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/ms-vscode.PowerShell-1.10.1.vsix?st=2018-12-12T05%3A10%3A26Z&se=2021-12-31T05%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=UE5%2FgIjdlPSTZZxv3iRu4xTBLLJNaNTEegsbP%2FosC4E%3D'
Download-WebInstallerFile -FileTitle 'Visual Studio Code - Azure Repos Extension (Blob)' -DestinationFile -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/ms-vsts.team-1.144.1.vsix?st=2018-12-12T05%3A10%3A46Z&se=2021-12-31T05%3A10%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=BF2NAcKD9EY5%2BZ2xSkh%2BYSmUnQM6gm%2FWG1jJy4JR%2F8w%3D'
Download-WebInstallerFile -FileTitle 'Visual Studio Code - Azure Resource Manager Tools Extension (Blob)' -DestinationFile -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/msazurermtools.azurerm-vscode-tools-0.4.2.vsix?st=2018-12-12T05%3A11%3A11Z&se=2021-12-31T05%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=Q5n%2BFB0SkN9ruc41RRaVQwAbOL0HXPPJf9mtbzmkSKQ%3D'
Download-WebInstallerFile -FileTitle 'Visual Studio Code - Docker Extension (Blob)' -DestinationFile -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/PeterJausovec.vscode-docker-0.4.0.vsix?st=2018-12-12T05%3A11%3A35Z&se=2021-12-31T05%3A11%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=YRilmGsTHtDI7IhXPff41Fr%2FSNHO1gvdfxQfXeFJpxI%3D'

## Run Installation commands.
Execute-InstallationCommand -CommandTitle 'Docker for Windows' -CommandPath 'C:\Docker for Windows Installer.exe' -CommandArguments 'install --quiet'
Execute-InstallationCommand -CommandTitle 'Visual Studio Code' -CommandPath 'C:\VSCodeSetup.exe' -CommandArguments '/VERYSILENT /MERGETASKS=!runcode'
Execute-InstallationCommand -CommandTitle 'Git for Windows' -CommandPath 'C:\Git.exe' -CommandArguments '/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"'

## Visual Studio Code Extension Installations.
## Execute-InstallationCommand -CommandTitle 'Visual Studio Code (PowerShell Extension)' -CommandPath 'C:\Program Files\Microsoft VS Code\Code.exe' -CommandArguments '--install-extension ms-vscode.powershell'
## Execute-InstallationCommand -CommandTitle 'Visual Studio Code (Azure Resource Manager Tools Extension)' -CommandPath 'C:\Program Files\Microsoft VS Code\Code.exe' -CommandArguments '--install-extension msazurermtools.azurerm-vscode-tools'
## Execute-InstallationCommand -CommandTitle 'Visual Studio Code (Azure Repos Extension)' -CommandPath 'C:\Program Files\Microsoft VS Code\Code.exe' -CommandArguments '--install-extension ms-vsts.team'
## Execute-InstallationCommand -CommandTitle 'Visual Studio Code (Docker Extension)' -CommandPath 'C:\Program Files\Microsoft VS Code\Code.exe' -CommandArguments '--install-extension peterjausovec.vscode-docker'

## Download AzureRm, AzureAD, GetPassword, BitBucket.v2, PackageManagement, Pester, Posh-Get, PowerShellGet PowerShell Modules.
Install-Package AzureRm -AllowClobber -Force -Confirm:$False
Install-Package AzureAD -AllowClobber -Force -Confirm:$False
Install-Package GetPassword -AllowClobber -Force -Confirm:$False
Install-Package BitBucket.v2 -AllowClobber -Force -Confirm:$False
Install-Package PackageManagement -AllowClobber -Force -Confirm:$False
Install-Package Pester -AllowClobber -Force -Confirm:$False
Install-Package Posh-Git -AllowClobber -Force -Confirm:$False
Install-Package PowerShellGet -AllowClobber -Force -Confirm:$False

## Finally after all configuration. Restart Computer.
## CustomScriptExtension shouldn't be used for restarting computer. However this script is verified and tested OK.
Restart-Computer -Force
