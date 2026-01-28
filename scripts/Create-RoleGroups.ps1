<#
.SYNOPSIS
    Provisionne les groupes role-assignable pour le projet Zero Trust.
.DESCRIPTION
    Crée les groupes avec la convention {CLIENT_PREFIX}-GRP-ROLE-<RoleName> et assigne les rôles.
    Nécessite le module Microsoft.Graph et les scopes : Group.ReadWrite.All, RoleManagement.ReadWrite.Directory
#>

# Configuration
$ClientPrefix = "LT" # A adapter selon {CLIENT_NAME}
$GroupsToCreate = @(
    @{ Name = "$ClientPrefix-GRP-ROLE-GA"; Role = "Global Administrator" },
    @{ Name = "$ClientPrefix-GRP-ROLE-PRA"; Role = "Privileged Role Administrator" },
    @{ Name = "$ClientPrefix-GRP-ROLE-CAA"; Role = "Conditional Access Administrator" },
    @{ Name = "$ClientPrefix-GRP-ROLE-SA"; Role = "Security Administrator" }
)

# Connexion (décommenter pour usage réel)
# Connect-MgGraph -Scopes "Group.ReadWrite.All", "RoleManagement.ReadWrite.Directory"

foreach ($Entry in $GroupsToCreate) {
    Write-Host "Vérification du groupe : $($Entry.Name)..." -ForegroundColor Cyan
    
    # 1. Création du groupe
    $groupParams = @{
        DisplayName        = $Entry.Name
        MailEnabled        = $false
        SecurityEnabled    = $true
        MailNickname       = ($Entry.Name -replace " ", "")
        IsAssignableToRole = $true
    }
    
    $Group = Get-MgGroup -Filter "DisplayName eq '$($Entry.Name)'"
    if (-not $Group) {
        $Group = New-MgGroup @groupParams
        Write-Host "Groupe crée : $($Group.Id)" -ForegroundColor Green
    }
    else {
        Write-Host "Le groupe existe déjà." -ForegroundColor Yellow
    }

    # 2. Assignation du rôle (Placeholder pour ID de définition)
    $RoleDef = Get-MgRoleManagementDirectoryRoleDefinition -Filter "DisplayName eq '$($Entry.Role)'"
    if ($RoleDef) {
        Write-Host "Prêt pour l'assignation du rôle $($Entry.Role) (ID: $($RoleDef.Id)) au groupe $($Group.Id)"
        # Note: L'assignation PIM se fait via une autre API (Governance Role Assignments)
    }
}
