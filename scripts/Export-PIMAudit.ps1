<#
.SYNOPSIS
    Exporte l'historique des activations PIM pour audit.
.DESCRIPTION
    Nécessite le scope : PrivilegedAccess.Read.AzureAD
#>

$ExportPath = "C:\Users\OWANDJA BORIS\.gemini\antigravity\scratch\legrand-tech-zerotrust\exports\PIM_Audit_$(Get-Date -Format 'yyyyMMdd').csv"

Write-Host "Extraction de l'historique PIM (30 derniers jours)..." -ForegroundColor Cyan

# Connect-MgGraph -Scopes "PrivilegedAccess.Read.AzureAD"

# Note: Utilisation de l'API beta ou v1.0 selon la version du module
# Get-MgPrivilegedAccessRoleAssignmentRequest -All ... 
# Pour l'exemple, on simule l'export des logs d'audit filtrés sur "Activate"

Write-Host "[MOCK] Requête Graph vers /roleManagement/directory/roleAssignmentScheduleRequests"
Write-Host "Export généré : $ExportPath" -ForegroundColor Green
