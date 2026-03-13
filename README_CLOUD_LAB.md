# Cloud Lab - Enregistreur de Requêtes GET 📊

Une application simple et performante pour enregistrer et afficher les requêtes HTTP GET avec l'adresse IP du client. Parfaite pour un TP Cloud Azure.

## 🚀 Démarrage rapide

### Installation locale
```bash
npm install
npm run build
npm start
```
Accédez à `http://localhost:3000` ou à votre port configuré.

### Développement avec hot-reload
```bash
npm run dev
```

## 📤 Déploiement sur Azure

### Option 1 : Avec PowerShell (Windows) ⭐ Recommandé
```powershell
# Exécutez directement depuis le répertoire du projet
.\deploy.ps1
```

### Option 2 : Avec Git
```bash
# Le remote Azure est déjà configuré
git push azure master
```

### Option 3 : Manuel
```bash
# Étape 1: Ajouter les fichiers
git add -A

# Étape 2: Créer un commit
git commit -m "Description de vos changements"

# Étape 3: Pousser vers Azure
git push azure master
```

## 🎯 Fonctionnalités

✅ **Enregistrement automatique** des requêtes GET  
✅ **Affichage de l'IP du client** dans chaque requête  
✅ **Interface responsive** moderne et élégante  
✅ **Statistiques en temps réel** (IPs uniques, chemins, etc.)  
✅ **API RESTful** pour consulter les logs  
✅ **Rafraîchissement automatique** toutes les 3 secondes  
✅ **Gestion des logs** (afficher, effacer, tester)

## 📋 Endpoints API

| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/api/logs` | Récupère tous les logs |
| GET | `/api/logs/:limit` | Récupère les N derniers logs |
| POST | `/api/logs/clear` | Efface tous les logs |
| GET | `/api/test-request` | Effectue une requête de test |

## 🛠️ Stack technologique

- **Frontend**: Vue.js 3 + Vite
- **Backend**: Express.js + Node.js
- **Deployment**: Azure App Service
- **Configuration**: web.config (IIS)

## 📁 Structure du projet

```
.
├── server.js           # Serveur Express principal ⭐
├── src/App.vue         # Interface Vue principale
├── dist/               # Build production (généré)
├── web.config          # Config IIS pour Azure
├── deploy.ps1          # Script de déploiement (Windows)
├── deploy.sh           # Script de déploiement (Linux/Mac)
└── package.json        # Dépendances npm
```

## 🌐 Accès à l'application

- **URL**: https://webapp-cloud-lab.azurewebsites.net
- **API**: https://webapp-cloud-lab.azurewebsites.net/api/logs

## 💡 Notes pour le TP

- Les logs sont stockés **en mémoire** (redémarrage = remise à zéro)
- Pour une production, considérez une base de données
- L'adresse IP est extraite des headers `x-forwarded-for` ou de `remoteAddress`
- Le User-Agent aide à identifier le type de client

## 🔧 Configuration

Les variables d'environnement utilisables :
- `PORT`: Port d'écoute (défaut: 3000)
- `NODE_ENV`: Mode (development/production)

## 📚 Documentation complète

Voir `DEPLOYMENT.md` pour plus de détails sur le déploiement et la configuration.

