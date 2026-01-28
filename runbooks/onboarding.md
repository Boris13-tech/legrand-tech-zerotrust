# Runbook: Onboarding & Offboarding Admin

## A) Onboarding (Ajout d'un privilège)
1. Vérifier l'approbation managériale (Ticket {TICKET_FORMAT}).
2. Ajouter l'utilisateur au groupe correspondant : `{CLIENT_PREFIX}-GRP-ROLE-<RoleName>`.
    - *Note: L'utilisateur ne doit JAMAIS être ajouté directement au rôle Entra ID.*
3. L'utilisateur devient immédiatement **Eligible** dans PIM.
4. Informer l'utilisateur qu'il doit configurer une méthode MFA phishing-resistant (FIDO2 / Windows Hello) si applicable.

## B) Offboarding (Retrait d'un privilège)
1. Retirer l'utilisateur du groupe `{CLIENT_PREFIX}-GRP-ROLE-<RoleName>`.
2. Vérifier dans PIM que les assignations éligibles ont disparu.
3. Forcer la déconnexion de l'utilisateur (Revoke-MgUserSignInSession).
4. Clôturer le ticket {TICKET_FORMAT}.

## C) Revue de transfert (Changement de poste)
1. Déclencher une Access Review immédiate si nécessaire.
2. Appliquer les étapes de l'Offboarding pour les anciens rôles.
3. Appliquer les étapes de l'Onboarding pour les nouveaux rôles.
