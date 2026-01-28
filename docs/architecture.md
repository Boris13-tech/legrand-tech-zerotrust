# Architecture Logique - Zero Trust Identity (Legrand Tech)

## Flux d'Authentification & Autorisation

```mermaid
graph TD
    %% Zones
    subgraph "Identity Perimeter (Zero Trust)"
        User([User / Admin]) -->|Sign-in| CA{Conditional Access Policy}
        BG([Break-Glass Account]) -.->|Emergency Access| CA
    end

    subgraph "Decision & Enforcement"
        CA -- "Risk / Non-Compliant" --> Block[Block Access]
        CA -- "MFA & Compliant" --> Entra[Microsoft Entra ID]
        BG -- "Bypass Rules" --> Entra
    end

    subgraph "Privileged Access (PIM)"
        Entra -->|Request Role| PIM{PIM Activation}
        PIM -- "Requires" --> Checks[MFA + Justification + Ticket]
        Checks --> Approval{Approval Required?}
        Approval -- No --> ActiveRole[Role Active (JIT)]
        Approval -- Yes --> Approvers[Approvers Group]
        Approvers -->|Approve| ActiveRole
    end

    subgraph "Monitoring & Alerting"
        Entra -.->|Log| Logs[Sign-in Logs]
        ActiveRole -.->|Log| Audit[Audit Logs]
        Logs -->|Filter: Break-glass| AlertBG((🚨 ALERT: Break-Glass))
        Audit -->|Filter: PIM Activation| AlertPIM((⚠️ ALERT: PIM))
    end
    
    %% Styling
    style BG fill:#b30000,stroke:#333,stroke-width:2px,color:#fff
    style AlertBG fill:#ff0000,stroke:#fee,stroke-width:2px,color:#fff,animate:flash
    style ActiveRole fill:#00b300,stroke:#333,stroke-width:2px,color:#fff
    style CA fill:#0078d4,stroke:#333,stroke-width:2px,color:#fff
```

## Composants Clés

### 1. Rôles et Groupes
- **Least Privilege** : Utilisation de rôles spécifiques (ex: `Conditional Access Administrator`) au lieu de `Global Administrator` permanent.
- **Groupes Role-assignable** : Point d'ancrage pour PIM. Pas de membres directs permanents.

### 2. PIM (Privileged Identity Management)
- **Just-In-Time (JIT)** : Activation temporaire avec justification.
- **MFA Required** : MFA requis à l'activation.
- **Approvals** : Double validation pour les rôles ultra-critiques (GA, PRA).

### 3. Conditional Access (Zero Trust)
- **Signal** : Utilisateur, Emplacement, Device Compliance, Risque.
- **Décision** : Allow, MFA, Block.
- **Enforcement** : Session persistante ou non.

### 4. Break-Glass (Emergency Access)
- **Exclusion** : Exclus de toutes les politiques CA pour éviter le lock-out.
- **Monitoring** : Alertes temps réel si connexion détectée.

## Instructions Draw.io
Pour un diagramme plus visuel, utilisez les éléments suivants :
1. **Azure Active Directory Icon** au centre.
2. **PIM Symbol** sur la droite pour les accès privilégiés.
3. **Lock Icon** pour les CA Policies.
4. **Cloud Icons** pour les ressources cibles.
5. **Red Shield Icon** pour les comptes Break-glass.
