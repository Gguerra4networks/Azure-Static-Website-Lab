# Lab 01 — Static Website on Azure Blob Storage
# Load these variables at the start of every session
# Run: . .\set-vars.ps1

$rg       = "rg-lab01-yourname"     # Replace yourname with your actual name
$location = "eastus"
$storage  = "stlab01yourname"       # Must be lowercase, 3-24 chars, globally unique

# After deployment, paste your live URL here as a comment:
# Live URL: https://

Write-Host "Variables loaded:" -ForegroundColor Cyan
Write-Host "  Resource Group : $rg"
Write-Host "  Location       : $location"
Write-Host "  Storage Account: $storage"
