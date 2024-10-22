# Define parameters
param(
    [string]$resourceGroupName = "myResourceGroup",
    [string]$location = "EastUS",
    [string]$storageAccountName = "mystorageaccount"
)

# Authenticate to Azure
Connect-AzAccount

# Check if the resource group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue

# Create the resource group if it doesn't exist
if (-not $resourceGroup) {
    Write-Host "Creating resource group '$resourceGroupName' in location '$location'..."
    New-AzResourceGroup -Name $resourceGroupName -Location $location
} else {
    Write-Host "Resource group '$resourceGroupName' already exists."
}

# Create the storage account
Write-Host "Creating storage account '$storageAccountName' in resource group '$resourceGroupName'..."
New-AzStorageAccount -ResourceGroupName $resourceGroupName `
                     -Name $storageAccountName `
                     -Location $location `
                     -SkuName "Standard_LRS" `
                     -Kind "StorageV2"

Write-Host "Storage account '$storageAccountName' created successfully."