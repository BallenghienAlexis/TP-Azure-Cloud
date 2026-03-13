# Instructions de Déploiement Azure

## ✅ Pré-requis satisfaits

- [x] Application Vue.js + Express.js créée
- [x] Backend avec enregistrement des requêtes GET
- [x] Interface frontend complète
- [x] Dépôt Git initialisé
- [x] Remote Azure configuré
- [x] Fichiers de configuration Azure (web.config)
- [x] Scripts de déploiement (PS1 + Bash)

## 📍 Credentials Azure

Avant de déployer, vous devez obtenir vos credentials de déploiement Azure :

### Via Azure CLI
```powershell
# Installer Azure CLI si nécessaire
# https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

az login
az webapp deployment list-publishing-credentials `
  --name webapp-cloud-lab `
  --resource-group <votre-groupe-ressource> `
  --query "{username:publishingUserName,password:publishingPassword}"
```

### Via Azure Portal
1. Allez sur https://portal.azure.com
2. Recherchez votre App Service `webapp-cloud-lab`
3. Allez dans **Paramètres** → **Centre de déploiement**
4. Récupérez les credentials FTP/Git

## 🚀 Procédure de déploiement complète

### Étape 1 : Configurer Git avec vos credentials
```powershell
# Git va demander vos credentials lors du premier push
# Vous pouvez aussi les configurer maintenant :

git config credential.helper store
```

### Étape 2 : Pousser votre code vers Azure
```powershell
# Option A : Utiliser le script de déploiement (RECOMMANDÉ)
.\deploy.ps1

# Option B : Manuellement
git push azure master
```

### Étape 3 : Suivre le déploiement
```powershell
# Voir les logs en temps réel
az webapp log tail --name webapp-cloud-lab --resource-group <votre-groupe>
```

### Étape 4 : Vérifier que l'application fonctionne
```powershell
# Tester l'API
$url = "https://webapp-cloud-lab.azurewebsites.net/api/logs"
Invoke-WebRequest -Uri $url -UseBasicParsing
```

## 🔑 Gestion des credentials

### Stocker les credentials de manière sécurisée
```powershell
# Git Credential Manager
git config --global credential.helper manager

# Ou utiliser une clé SSH (recommandé pour la production)
# Voir: https://learn.microsoft.com/en-us/azure/app-service/deploy-configure-credentials
```

### Si vous avez oublié vos credentials
```powershell
az webapp deployment user set `
  --user-name <votre-username> `
  --password <votre-nouveau-mot-de-passe>
```

## 🎯 Vérification post-déploiement

Accédez à votre application :
- **URL publique** : https://webapp-cloud-lab.azurewebsites.net
- **API test** : https://webapp-cloud-lab.azurewebsites.net/api/logs

### Tester les requêtes GET
```powershell
# Effectuer quelques requêtes GET
curl "https://webapp-cloud-lab.azurewebsites.net/?test=1"
curl "https://webapp-cloud-lab.azurewebsites.net/api/logs"

# Ou via PowerShell
Invoke-WebRequest -Uri "https://webapp-cloud-lab.azurewebsites.net/" -UseBasicParsing
```

## 📊 Monitoring et troubleshooting

### Voir les logs d'application
```powershell
# Logs en temps réel
az webapp log tail -n webapp-cloud-lab -g <votre-groupe>

# Télécharger les logs
az webapp log download -n webapp-cloud-lab -g <votre-groupe>
```

### Erreurs courantes

| Erreur | Solution |
|--------|----------|
| `fatal: could not read Username` | Configurer les credentials Git |
| `Port 3000 already in use` | Changer la variable `PORT` |
| `ENOENT: no such file or directory` | Vérifier que `dist/` existe (npm run build) |
| `Cannot GET /` | Vérifier que web.config est présent |

## 🔄 Mise à jour du code

Après des modifications locales :
```powershell
git add -A
git commit -m "Description des changements"
.\deploy.ps1  # ou git push azure master
```

## 📝 Notes importantes

- Le déploiement prend 1-2 minutes
- Les logs en mémoire sont perdus lors d'un redémarrage
- Pour la production, utilisez une base de données
- Les credentials de déploiement ne sont pas les mêmes que vos credentials Azure

---

**Application prête pour le TP ! 🎉**

