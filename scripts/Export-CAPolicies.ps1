<#
.SYNOPSIS
    Exporte les politiques Conditional Access en JSON pour audit.
.DESCRIPTION
    Nécessite le module Microsoft.Graph.Identity.ConditionalAccess et scope : Policy.Read.All
#>

$ExportPath = "C:\Users\OWANDJA BORIS\.gemini\antigravity\scratch\legrand-tech-zerotrust\exports"
if (-not (Test-Path $ExportPath)) { New-Item -ItemType Directory -Path $ExportPath }

Write-Host "Récupération des politiques d'Accès Conditionnel..." -ForegroundColor Yellow

# Connect-MgGraph -Scopes "Policy.Read.All"

$Policies = Get-MgIdentityConditionalAccessPolicy

foreach ($Policy in $Policies) {
    $CleanName = $Policy.DisplayName -replace '[\\/:*?"<>|]', '_'
    $File = Join-Path $ExportPath "$CleanName.json"
    
    Write-Host "Export de : $($Policy.DisplayName)" -ForegroundColor Gray
    $Policy | ConvertTo-Json -Depth 10 | Out-File $File
}

Write-Host "Export terminé. Fichiers situés dans $ExportPath" -ForegroundColor Green
