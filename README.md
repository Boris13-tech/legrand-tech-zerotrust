#  Projet Zero Trust Identity & Privileged Access (Legrand-Tech)

Bienvenue dans le dépôt central du projet de sécurisation des identités pour le client Maldo. Ce guide explique la démarche adoptée, étape par étape, pour transformer un environnement classique en un modèle Zero Trust.

---

# Vue d'Ensemble
L'objectif est simple : "Never Trust, Always Verify". Nous avons supprimé les privilèges permanents pour les remplacer par des accès temporaires, sécurisés et audités.

---

# Étapes de Réalisation (A to Z)

# Étape 1 : Design de l'Architecture Logique
Nous avons commencé par dessiner le flux de sécurité. Au lieu d'assigner des rôles directement aux gens, nous utilisons des groupes "role-assignable".
- **Fichier** : [architecture.md](docs/architecture.md)
- **Concept** : L'utilisateur appartient à un groupe "éligible". Pour agir, il doit activer son rôle via Microsoft Entra PIM.

# Étape 2 : Définition du Catalogue d'Artefacts
On ne peut pas sécuriser ce qu'on ne liste pas. Nous avons répertorié :
- Les **4 groupes clés** (GA, PRA, CAA, SA).
- Les **règles PIM** (durée de 4h, MFA requis, approbation par les pairs).
- La stratégie d'Accès Conditionnel (CA).
- **Fichier** : [catalogue_artefacts.md](docs/catalogue_artefacts.md)

# Étape 3 : Automatisation PowerShell & Graph
Pour garantir la répétabilité, nous avons codé l'infrastructure.
1. **Provisioning** : `Create-RoleGroups.ps1` crée les groupes avec les paramètres de sécurité requis.
2. **Audit & Export** : `Export-CAPolicies.ps1` et `Export-PIMAudit.ps1` permettent de garder une trace de la configuration.
3. **Gouvernance** : `New-AccessReview.ps1` automatise la revue mensuelle des accès.

# Étape 4 : Déploiement Progressif du Conditional Access
Nous avons créé des templates JSON pour les politiques de sécurité.
- **Sécurité maximale** : Blocage de l'authentification héritée, MFA obligatoire pour tous, MFA phishing-resistant pour les admins.
- **Prudence** : Toutes les règles sont livrées en mode "Report-only" pour ne pas casser la production lors des premiers jours.
- **Dossier** : [templates/](exports/templates/)

# Étape 5 : Protection "Break-Glass" (Urgence)
Pour éviter tout "Lock-out" accidentel, nous avons sanctuarisé deux comptes d'urgence.
- **Règle** : Ils sont exclus de toutes les politiques CA.
- **Usage** : Uniquement via une procédure stricte de récupération de mot de passe physique.
- **Fichier** : [break_glass_proc.md](runbooks/break_glass_proc.md)

# Étape 6 : Monitoring & Alerting (Vigilance)
Nous avons écrit des requêtes KQL (Kusto) prêtes pour Azure Log Analytics.
- Alerte immédiate sur connexion Break-glass.
- Audit des changements de politiques CA.
- **Fichier** : [monitoring_queries.md](docs/monitoring_queries.md)

---

# Structure du Repository (Pourquoi ces fichiers ?)

- `/docs` : Le "cerveau" du projet (Architecture, Critères de succès, Monitoring).
- `/runbooks` : Le "manuel d'utilisation" pour les admins au quotidien.
- `/scripts` : La "boîte à outils" pour automatiser et auditer.
- `/exports` : Les sauvegardes et les modèles (templates) de configuration.

---

# Comment valider le projet ?
Consultez la [Definition of Done](docs/definition_of_done.md) pour voir la check-list finale des preuves à fournir (captures écran et exports) pour clore le projet.

---

> [!TIP]
> **Conseil de mentor** : Commencez toujours par la phase d'Audit (scripts d'export) avant d'appliquer les changements, pour avoir un point de retour arrière sain.
