# 🔐 CONFIGURATION DES CREDENTIALS AZURE DANS GITHUB

Le workflow GitHub Actions nécessite des credentials Azure pour déployer. Voici comment les configurer :

## ✅ ÉTAPE 1 : GÉNÉRER LES CREDENTIALS AZURE

### Option A : Via Azure CLI (Recommandé)

Exécutez cette commande dans PowerShell :

```powershell
az ad sp create-for-rbac --name "TP-Azure-Cloud-Deploy" --role contributor --scopes /subscriptions/{subscription-id}/resourceGroups/{resource-group-name} --json-auth
```

Remplacez :
- `{subscription-id}` : Votre ID d'abonnement Azure
- `{resource-group-name}` : Votre groupe de ressources (ex: "cloud-lab-rg")

**Résultat** : Vous obtiendrez un JSON ressemblant à :
```json
{
  "clientId": "...",
  "clientSecret": "...",
  "subscriptionId": "...",
  "tenantId": "...",
  "activeDirectoryEndpointUrl": "...",
  "resourceManagerEndpointUrl": "...",
  "activeDirectoryGraphResourceId": "...",
  "sqlManagementEndpointUrl": "...",
  "galleryEndpointUrl": "...",
  "managementEndpointUrl": "..."
}
```

### Option B : Via Azure Portal

1. Allez sur https://portal.azure.com
2. Cherchez "App registrations"
3. Cliquez sur "New registration"
4. Remplissez les informations
5. Allez dans "Certificates & secrets"
6. Créez un "Client secret"

## ✅ ÉTAPE 2 : AJOUTER LE SECRET DANS GITHUB

1. Allez sur : https://github.com/BallenghienAlexis/TP-Azure-Cloud

2. Cliquez sur **Settings** (onglet)

3. Allez à **Secrets and variables** → **Actions**

4. Cliquez sur **New repository secret**

5. Créez un secret nommé : `AZURE_CREDENTIALS`

6. Collez le JSON entier obtenu à l'étape 1 dans la valeur

7. Cliquez sur **Add secret**

## ✅ ÉTAPE 3 : VÉRIFIER LA CONFIGURATION

Votre secret est maintenant stocké de manière sécurisée sur GitHub.

Le workflow accédera à `${{ secrets.AZURE_CREDENTIALS }}` automatiquement.

## 🚀 DÉCLENCHER UN NOUVEAU DÉPLOIEMENT

Une fois le secret configuré, faites un push pour déclencher le workflow :

```bash
git push github master
```

Ou créez un commit vide pour forcer le redéploiement :

```bash
git commit --allow-empty -m "Trigger deployment avec Azure credentials"
git push github master
```

## 🔍 VÉRIFIER LE STATUT

Allez sur : https://github.com/BallenghienAlexis/TP-Azure-Cloud/actions

Vous devriez voir le workflow en cours d'exécution.

Statut attendu :
- 🟡 In progress (en cours)
- 🟢 Success (succès) - le déploiement est terminé
- 🔴 Failed (échoué) - regardez les logs pour les erreurs

## 📊 FLUX DE DÉPLOIEMENT

```
git push
  ↓
GitHub Actions démarre
  ↓
Azure Login (avec credentials)
  ↓
npm install && npm run build
  ↓
Azure WebApps Deploy
  ↓
https://webapp-cloud-lab.azurewebsites.net
  ↓
✅ Application en ligne !
```

## ⚠️ SÉCURITÉ

- Ne partagez JAMAIS le JSON brut des credentials
- GitHub chiffre les secrets automatiquement
- Seul le workflow GitHub peut accéder aux secrets
- Les logs n'affichent jamais les valeurs des secrets

## ❓ BESOIN D'AIDE ?

Si vous n'avez pas d'ID d'abonnement :

```powershell
az account show --query "id" -o tsv
```

Si vous n'avez pas de groupe de ressources :

```powershell
az group list --query "[].name" -o tsv
```

