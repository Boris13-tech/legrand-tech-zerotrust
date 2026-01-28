# Runbook: Audit Mensuel Zero Trust

## 1. KPIs de sécurité
- % d'utilisateurs avec MFA activé (Cible: 100%).
- Nombre de Global Admins permanents (Cible: 0 hors break-glass).
- Nombre d'activations PIM suspectes (hors horaires ou sans ticket).

## 2. Actions à réaliser
1. **PIM Review** : Exporter les activations du mois (`Export-PIMAudit.ps1`).
2. **Access Reviews** : Vérifier que toutes les revues ont été complétées par les approvers ({APPROVERS_GROUP_NAME}).
3. **CA Changes** : Vérifier l'historique des modifications des politiques Conditional Access.
4. **Break-glass** : Confirmer l'absence de sign-ins sur les comptes BG.

## 3. Reporting
Générer un rapport PDF incluant :
- Liste des nouveaux admins éligibles.
- Statut des politiques "Report-only" vers "Enforced".
- Exceptions documentées.
