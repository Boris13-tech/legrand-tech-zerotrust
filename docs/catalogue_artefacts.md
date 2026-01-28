# Catalogue des Artefacts - Zero Trust

## A) Groupes Role-assignable
Convention : `{CLIENT_PREFIX}-GRP-ROLE-<RoleName>`

| Nom Groupe | Description | Rôle Associé | Membres (Eligibles) |
| :--- | :--- | :--- | :--- |
| LT-GRP-ROLE-GA | Global Admins (PIM) | Global Administrator | Admin Sec, Cloud Lead |
| LT-GRP-ROLE-PRA | Privileged Role Admins | Privileged Role Administrator | IAM Team |
| LT-GRP-ROLE-CAA | Conditional Access Admins | Conditional Access Administrator | Security Ops |
| LT-GRP-ROLE-SA | Security Admins | Security Administrator | SOC Analysts |

## B) Paramètres PIM

| Paramètre | Global Admin | Security Admin |
| :--- | :--- | :--- |
| **Durée Max** | {PIM_GA_DURATION} | {PIM_SA_DURATION} |
| **Justification** | Requise | Requise |
| **Ticket ITSM** | Requis ({TICKET_FORMAT}) | Requis ({TICKET_FORMAT}) |
| **MFA à l'activation**| Oui | Oui |
| **Approbation** | {APPROVERS_GROUP_NAME} | Pas d'approbation (si SA) |
| **Notifications** | {PIM_NOTIFICATIONS} | {PIM_NOTIFICATIONS} |

## C) Conditional Access (CA) Policies

| ID | Nom | Cible | Conditions | Contrôles | Statut |
| :--- | :--- | :--- | :--- | :--- | :--- |
| CA-01 | Block Legacy Auth | All Users | All Apps | Block Access | Report-only |
| CA-02 | Require MFA All | All Users | All Apps | Require MFA | Report-only |
| CA-03 | Admins Phishing-Resistant| Admin Roles | Portails Admin | Require Auth Strength | Report-only |
| CA-06 | Protect Admin Portals | All Users | Microsoft Admin Portals | Require MFA + Compliant | Report-only |

> [!IMPORTANT]
> **Exclusions CA** : Tous les break-glass ({BREAKGLASS_1_UPN}, {BREAKGLASS_2_UPN}) doivent être exclus de TOUTES les politiques pour garantir l'accès en cas de dysfonctionnement du MFA ou du CA.

## D) Break-Glass Accounts
- **UPNs** : {BREAKGLASS_1_UPN}, {BREAKGLASS_2_UPN}
- **Role** : Permanent Global Administrator.
- **Exception** : Seuls comptes avec mot de passe permanent (stocké physiquement, ex: coffre-fort).
- **Monitoring** : Alerte via Log Analytics sur `Sign-in ID`.
