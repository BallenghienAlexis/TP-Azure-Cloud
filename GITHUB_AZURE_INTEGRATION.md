# 🚀 CONNEXION GITHUB À AZURE - DÉPLOIEMENT AUTOMATIQUE

Votre code a été poussé vers GitHub et est maintenant prêt pour un déploiement automatique sur Azure !

## ✅ ÉTAPES À FAIRE DANS AZURE PORTAL

### 1️⃣ Aller au Centre de Déploiement
1. Ouvrez https://portal.azure.com
2. Cherchez votre App Service **webapp-cloud-lab**
3. Allez dans le menu de gauche → **Centre de déploiement**

### 2️⃣ Connecter GitHub
1. Cliquez sur **Source** → Sélectionnez **GitHub**
2. Cliquez sur **Autoriser**
3. Acceptez les permissions GitHub

### 3️⃣ Sélectionner le Dépôt et la Branche
1. **Organisation** : BallenghienAlexis
2. **Référentiel** : TP-Azure-Cloud
3. **Branche** : master

### 4️⃣ Configurer la Pile de Runtime
1. **Framework** : Node.js
2. **Version d'exécution** : Node 18 LTS (ou plus récente)
3. **Commande de build** : `npm install && npm run build`
4. **Commande de démarrage** : `node server.js`

### 5️⃣ Enregistrer
Cliquez sur **Enregistrer**

→ Azure configurera automatiquement un **GitHub Action** pour déployer à chaque push vers master

---

## ✅ ALTERNATIVE : CLI Azure

Si vous préférez utiliser le CLI :

```bash
# Configurer le déploiement GitHub
az webapp deployment source config \
  --name webapp-cloud-lab \
  --resource-group <votre-groupe> \
  --repo-url https://github.com/BallenghienAlexis/TP-Azure-Cloud.git \
  --branch master \
  --manual-integration
```

---

## 📋 INFORMATIONS DU REPO

- **URL du dépôt** : https://github.com/BallenghienAlexis/TP-Azure-Cloud.git
- **Branche principale** : master
- **Fichier d'entrée** : server.js
- **Build** : npm run build (compile Vue.js)
- **Commande de démarrage** : node server.js

---

## 🔄 APRÈS LA CONFIGURATION

Une fois connecté :

1. **Tout commit sur `master`** → Déploiement automatique sur Azure
2. **GitHub Action** lancera le build et le déploiement
3. **Statut du déploiement** visible sur GitHub (onglet Actions)

### Exemple : 
```bash
# Simple push = déploiement automatique
git push github master
```

---

## ✨ AVANTAGES DU DÉPLOIEMENT GITHUB

✅ Déploiement automatique à chaque push  
✅ Historique des déploiements visible dans GitHub  
✅ Logs d'Azure App Service disponibles  
✅ Rollback facile (revert commit = redéploiement ancienne version)  
✅ Gestion de code complète sur GitHub  

---

## 🐛 TROUBLESHOOTING

### L'App Service ne se déploie pas
1. Vérifier le status dans GitHub Actions
2. Vérifier les logs dans Azure : **Centre de déploiement** → **Logs**
3. Vérifier que .deployment et web.config sont présents

### Erreur "Cannot find module"
- Vérifier que `npm install` s'exécute (dans .deployment)
- Vérifier package.json et package-lock.json

### Application affiche toujours "en cours d'exécution"
- Attendre 2-3 minutes
- Recharger la page (Ctrl+F5)
- Vérifier les logs Azure

---

## 📊 RÉSUMÉ

```
GitHub (TP-Azure-Cloud)
    ↓ (master branch)
    ↓ (Commit/Push)
    ↓
Azure App Service
    ↓ (Télécharge code)
    ↓ (npm install)
    ↓ (npm run build)
    ↓ (node server.js)
    ↓
https://webapp-cloud-lab.azurewebsites.net
    ↓
✅ Application en ligne !
```

---

Prêt pour le déploiement automatique ! 🚀

