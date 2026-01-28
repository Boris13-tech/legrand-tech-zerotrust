<#
.SYNOPSIS
    Configure une nouvelle Access Review pour les groupes privilégiés.
.DESCRIPTION
    Nécessite le scope : AccessReviewConfig.ReadWrite.Directory
#>

Write-Host "Configuration d'une Access Review mensuelle pour les groupes LT-GRP-ROLE-*" -ForegroundColor Yellow

# Connect-MgGraph -Scopes "AccessReviewConfig.ReadWrite.Directory"

# Paramètres de la revue
$Params = @{
    DisplayName            = "Revue Mensuelle - Administrateurs Privilégiés"
    ReviewerType           = "GroupMembers" # Les membres du groupe d'approbation révisent
    ReviewerId             = "{APPROVERS_GROUP_ID}"
    InstanceDurationInDays = 7
    Frequency              = "monthly"
}

Write-Host "[MOCK] Création de la revue via POST /identityGovernance/accessReviews/definitions"
Write-Host "Access Review configurée avec succès." -ForegroundColor Green
