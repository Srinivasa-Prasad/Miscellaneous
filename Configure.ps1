Function fnConfigure(){
    ## Configure Visual Studio Code Installation.
    "$(Get-Date) - Information - Initiating PowerShell DSC Configuration."| Out-File C:\DSCConfigure.log -Append
    
    "$(Get-Date) - Information - Initiating Visual Studio Code Installation."| Out-File C:\DSCConfigure.log -Append
    $EXE = "C:\VSCodeSetup.exe"
    $Arguments = "/VERYSILENT /MERGETASKS=!runcode"
    
    Start-Process $EXE $Arguments -Wait
    
    "$(Get-Date) - Information - Completed Visual Studio Code Installation.."| Out-File C:\DSCConfigure.log -Append
}