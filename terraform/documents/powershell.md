az login
az account set --subscription=""             


*************************************************
az account list


************************************************
Create Service Principal

$sp = New-AzADServicePrincipal -Scope /subscriptions/<azure_subscription_id>
$sp.ServicePrincipalNames
$UnsecureSecret = ConvertFrom-SecureString -SecureString $sp.Secret -AsPlainText

***********************************************
Login with Service Principal

$spCredential = Get-Credential
$spName = "<service_principal_name>"
$spPassword = ConvertTo-SecureString "<service_principal_password>" -AsPlainText -Force
$spCredential = New-Object System.Management.Automation.PSCredential($spName , $spPassword)
Connect-AzAccount -Credential $spCredential -Tenant "<azure_subscription_tenant_id>" -ServicePrincipal


**********************************************
Set Environment Variables in session

$env:ARM_CLIENT_ID="<service_principal_app_id>"
$env:ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
$env:ARM_TENANT_ID="<azure_subscription_tenant_id>"


