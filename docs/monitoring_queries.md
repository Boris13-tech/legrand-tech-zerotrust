# Requêtes Log Analytics pour Monitoring Zero Trust

## 1. Alerting Break-Glass Connection
Alerte à déclencher dès qu'un compte break-glass se connecte.

```kusto
SigninLogs
| where UserPrincipalName in~ ("{BREAKGLASS_1_UPN}", "{BREAKGLASS_2_UPN}")
| project TimeGenerated, UserPrincipalName, IPAddress, Location, ResultType
| order by TimeGenerated desc
```

## 2. PIM Activation Audit
Surveiller les activations de rôles sensibles.

```kusto
AuditLogs
| where OperationName == "Add member to role (PIM activation)"
| extend TargetRole = tostring(TargetResources[0].displayName)
| extend User = tostring(InitiatedBy.user.userPrincipalName)
| project TimeGenerated, User, TargetRole, Result
| order by TimeGenerated desc
```

## 3. Modification de Politique d'Accès Conditionnel
Surveiller les changements pour éviter les désactivations malveillantes.

```kusto
AuditLogs
| where TargetResources[0].type == "ConditionalAccessPolicy"
| where OperationName in ("Update conditional access policy", "Delete conditional access policy")
| project TimeGenerated, OperationName, Target = TargetResources[0].displayName, User = InitiatedBy.user.userPrincipalName
```
