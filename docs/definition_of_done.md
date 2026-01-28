# Definition of Done (DoD) - Projet Zero Trust

## 1. Critères de Validation
- [ ] Aucun compte "permanent" n'est assigné à un rôle privilégié (GA, Security Admin, etc.) sauf les 2 comptes Break-glass.
- [ ] Les comptes Break-glass sont exclus des politiques d'Accès Conditionnel (CA-01, CA-02, etc.).
- [ ] La politique CA-01 (Block Legacy Auth) est activée en mode "Report-only" au minimum.
- [ ] Tous les admins éligibles doivent impérativement passer par PIM pour activer leur rôle.
- [ ] L'activation PIM pour les rôles critiques (GA, PRA) requiert une approbation du groupe {APPROVERS_GROUP_NAME}.
- [ ] Un ticket ITSM (format {TICKET_FORMAT}) est exigé pour toute activation PIM.

## 2. Liste des Preuves (Evidence List)
Les fichiers doivent être nommés selon la convention : `LT-ZERO-TRUST-EVIDENCE-<Name>-<Date>.png`

1. **Capture d'écran** : Liste des membres du rôle "Global Administrator" (montrant uniquement les BG).
2. **Capture d'écran** : Paramètres PIM pour le rôle GA (montrant la durée, MFA et approbateurs).
3. **Capture d'écran** : Liste des politiques Conditional Access (Statut Report-only).
4. **Export JSON** : Configuration de la politique CA-01.
5. **Export CSV** : Audit logs PIM montrant une activation réussie avec justification.
6. **Capture d'écran** : Alerte de connexion configurée pour les comptes Break-glass.
