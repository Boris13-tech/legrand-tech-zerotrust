# Runbook: Emergency Access (Break-Glass)

## 1. Objectif
Garantir l'accès au tenant Microsoft Entra ID si toutes les méthodes d'authentification standard (MFA, CA) sont défaillantes.

## 2. Comptes concernés
- **UPNs** : {BREAKGLASS_1_UPN}, {BREAKGLASS_2_UPN}
- **Rôle** : Global Administrator permanent.

## 3. Procédure d'activation
1. Récupérer les identifiants dans le coffre-fort physique {STORAGE_LOCATION}.
2. Se connecter sur `https://portal.azure.com`.
3. Désactiver ou modifier la politique CA défaillante.
4. Effectuer les actions de remédiation.

## 4. Post-incident (Rollback & Clean-up)
- Changer le mot de passe du compte utilisé.
- Vérifier que les alertes de connexion ont bien été déclenchées.
- Documenter l'usage via le ticket {TICKET_FORMAT}.
- Replacer les identifiants dans le coffre.

## 5. Audit trimestriel
- **Date** : 1er lundi du trimestre.
- **Action** : Tester la connexion (sans finaliser si possible ou en changeant le mot de passe immédiatement après).
- **Validation** : Vérifier que l'alerte de monitoring a été reçue.
