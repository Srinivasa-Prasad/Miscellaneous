Import-Module AzureRm

If(!(Get-AzureRmContext)){
    Connect-AzureRmAccount
}

## Deploy Infra
New-AzureRmResourceGroup -Name SrinivasaLabs-Infra -Location 'East US' -Force
New-AzureRmResourceGroupDeployment -Name ARMInfraDeploy -ResourceGroupName SrinivasaLabs-Infra -TemplateFile https://raw.githubusercontent.com/Srinivasa-Prasad/Miscellaneous/master/DeployInfra.json

## Deploy VM
New-AzureRmResourceGroup -Name PRASASRI -Location 'East US' -Force
New-AzureRmResourceGroupDeployment -Name ARMVMDeploy -ResourceGroupName PRASASRI -TemplateFile https://raw.githubusercontent.com/Srinivasa-Prasad/Miscellaneous/master/DeployVM.json
