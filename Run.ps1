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

## Create Software Folder Under C Drive
New-Item -ItemType Directory C:\Software

## Install Hyper-V Feature required for Docker Installation.
"$(Get-Date) - Information - Initiating Hyper-V Feature installation."| Out-File C:\Configure.log -Append
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools
"$(Get-Date) - Information - Hyper-V Feature installation completed."| Out-File C:\Configure.log -Append

## Download Installer Files.
Download-WebInstallerFile -FileTitle 'Docker for Windows (Docker Website)' -DestinationFile 'C:\Software\Docker for Windows Installer.exe' -SourceFile 'https://download.docker.com/win/stable/Docker for Windows Installer.exe'
Download-WebInstallerFile -FileTitle 'Visual Studio Code (Blob)' -DestinationFile 'C:\Software\VSCodeSetup.exe' -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/VSCodeSetup-x64-1.29.1.exe?st=2018-12-10T04%3A04%3A40Z&se=2020-01-01T04%3A04%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=HcgbJvJkyCkrdRWSw57cZdgtkG40u70tt92EHyux374%3D'
Download-WebInstallerFile -FileTitle 'Git (Blob)' -DestinationFile 'C:\Software\Git.exe' -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/Git-2.19.1-64-bit.exe?st=2018-12-11T23%3A42%3A12Z&se=2020-12-30T23%3A42%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=NIGD9JpQw1U2L5GbTSHoFGpEs4jg8Fzwhgg7kvxDHE8%3D'
Download-WebInstallerFile -FileTitle '7-Zip (7-Zip Website)' -DestinationFile 'C:\Software\7z.msi' -SourceFile 'https://www.7-zip.org/a/7z1805-x64.msi'
Download-WebInstallerFile -FileTitle 'Azure Data Studio (Blob)' -DestinationFile 'C:\Software\AzureDataStudio.exe' -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/azuredatastudio-windows-setup-1.2.4.exe?st=2018-12-14T08%3A34%3A46Z&se=2020-12-31T08%3A34%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=hOKydqQvwEf5iSbWV4L1n7OrumvLezR5BAnua8rlij8%3D'
Download-WebInstallerFile -FileTitle 'Azure Storage Explorer (Blob)' -DestinationFile 'C:\Software\AzureStorageExplorer.exe' -SourceFile 'https://srinivasablobstorage.file.core.windows.net/downloads/StorageExplorer.exe?st=2018-12-14T08%3A35%3A11Z&se=2020-12-31T08%3A35%3A00Z&sp=rl&sv=2018-03-28&sr=f&sig=4IDNe7n1V6L8dW6%2BvZuTTTsIaJOCWMSjHSCYL36w%2FcY%3D'
Download-WebInstallerFile -FileTitle 'Putty (Putty Website)' -DestinationFile 'C:\Software\Putty.msi' -SourceFile 'https://the.earth.li/~sgtatham/putty/latest/w64/putty-64bit-0.70-installer.msi'

## Run Installation commands.
Execute-InstallationCommand -CommandTitle 'Docker for Windows' -CommandPath 'C:\Software\Docker for Windows Installer.exe' -CommandArguments 'install --quiet'
Execute-InstallationCommand -CommandTitle 'Visual Studio Code' -CommandPath 'C:\Software\VSCodeSetup.exe' -CommandArguments '/VERYSILENT /MERGETASKS=!runcode'
Execute-InstallationCommand -CommandTitle 'Git for Windows' -CommandPath 'C:\Software\Git.exe' -CommandArguments '/VERYSILENT /NORESTART /NOCANCEL /SP- /CLOSEAPPLICATIONS /RESTARTAPPLICATIONS /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"'
Execute-InstallationCommand -CommandTitle '7z' -CommandPath 'C:\Windows\System32\MsiExec.exe' -CommandArguments '/i C:\Software\7z.msi /qn'
Execute-InstallationCommand -CommandTitle 'Putty' -CommandPath 'C:\Windows\System32\MsiExec.exe' -CommandArguments '/i C:\Software\Putty.msi /qn'
Execute-InstallationCommand -CommandTitle 'Azure Data Studio' -CommandPath 'C:\Software\AzureDataStudio.exe' -CommandArguments '/VERYSILENT /MERGETASKS=!runcode'
Execute-InstallationCommand -CommandTitle 'Azure Storage Explorer' -CommandPath 'C:\Software\AzureStorageExplorer.exe' -CommandArguments '/VERYSILENT /MERGETASKS=!runcode'

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