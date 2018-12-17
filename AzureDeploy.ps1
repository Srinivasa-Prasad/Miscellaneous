Import-Module AzureRm

If((Get-AzureRmContext).Account.Id -ne 'srinivasa.prasad@hotmail.com'){
    Connect-AzureRmAccount
}

## Deploy Infra
## New-AzureRmResourceGroup -Name SrinivasaLabs-Infra -Location 'East US' -Force
## New-AzureRmResourceGroupDeployment -Name ARMInfraDeploy -ResourceGroupName SrinivasaLabs-Infra -TemplateFile https://raw.githubusercontent.com/Srinivasa-Prasad/Miscellaneous/master/DeployInfra.json

## Deploy VM
New-AzureRmResourceGroup -Name PRASASRI-VS -Location 'East US' -Force
New-AzureRmResourceGroupDeployment -Name ARMVMDeploy -ResourceGroupName PRASASRI-VS -TemplateFile https://raw.githubusercontent.com/Srinivasa-Prasad/Miscellaneous/master/DeployCloud.json

New-AzureRmResourceGroup -Name PRASASRI-WS -Location 'East US' -Force
New-AzureRmResourceGroupDeployment -Name ARMVMDeploy -ResourceGroupName PRASASRI-Ws -TemplateFile https://raw.githubusercontent.com/Srinivasa-Prasad/Miscellaneous/master/DeployUtility.json