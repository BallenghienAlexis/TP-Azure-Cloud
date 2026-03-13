# Cloud Lab - Enregistreur de Requêtes GET

Une application simple pour enregistrer et afficher les requêtes GET avec l'adresse IP du client. Idéale pour un TP Cloud Azure.

## Fonctionnalités

✅ Enregistrement automatique de toutes les requêtes GET
✅ Affichage de l'adresse IP du client
✅ Informations sur le User-Agent
✅ Interface moderne et responsive
✅ Statistiques en temps réel
✅ API pour consulter et gérer les logs
✅ Rafraîchissement automatique toutes les 3 secondes

## Architecture

- **Backend**: Node.js + Express.js
- **Frontend**: Vue.js 3 + Vite
- **Port**: 3000 (ou variable d'environnement `PORT`)

## Installation locale

```bash
# Installer les dépendances
npm install

# Construire le frontend
npm run build

# Démarrer le serveur
npm start
```

L'application sera disponible à `http://localhost:3000`

## Développement local avec hot reload

```bash
# Terminal 1: Démarrer Vite en mode développement
npm run dev

# Terminal 2: Démarrer le serveur Express (facultatif)
node server.js
```

## API Endpoints

### GET `/api/logs`
Récupère tous les logs enregistrés
```json
[
  {
    "timestamp": "2026-03-13T10:30:45.123Z",
    "method": "GET",
    "path": "/",
    "url": "/?test=true",
    "ip": "192.168.1.100",
    "userAgent": "Mozilla/5.0..."
  }
]
```

### GET `/api/logs/:limit`
Récupère les N derniers logs
```
GET /api/logs/10
```

### POST `/api/logs/clear`
Efface tous les logs
```json
{
  "message": "Logs cleared",
  "count": 0
}
```

## Déploiement sur Azure

### Prérequis
- Compte Azure
- Azure CLI installé
- Git configuré

### Étapes

1. **Initialiser le dépôt Git (si nécessaire)**
```bash
git init
git add .
git commit -m "Initial commit"
```

2. **Ajouter le dépôt Azure en tant que remote**
```bash
git remote add azure https://webapp-cloud-lab-fphxbwa7f8ejhzau.scm.francecentral-01.azurewebsites.net:443/webapp-cloud-lab.git
```

3. **Configurer le déploiement**
```bash
# Obtenir les credentials de déploiement
az webapp deployment list-publishing-credentials --name webapp-cloud-lab --resource-group <votre-groupe-ressource>
```

4. **Pousser vers Azure**
```bash
git push azure main
# ou
git push azure master
```

5. **Vérifier le déploiement**
Accédez à votre application sur https://webapp-cloud-lab.azurewebsites.net

### Configuration Azure App Service

Assurez-vous que les paramètres d'application sont configurés:

```
NODE_ENV: production
SCM_DO_BUILD_DURING_DEPLOYMENT: true
```

## Variables d'environnement

- `PORT`: Port d'écoute (défaut: 3000)
- `NODE_ENV`: Environnement (development/production)

## Structure du projet

```
.
├── server.js              # Serveur Express principal
├── web.config             # Configuration IIS pour Azure
├── package.json           # Dépendances Node.js
├── vite.config.js         # Configuration Vite
├── index.html             # HTML principal
├── src/
│   ├── App.vue            # Composant principal
│   ├── main.js            # Point d'entrée Vue
│   ├── assets/            # Assets statiques
│   └── components/        # Composants Vue
└── dist/                  # Build output (généré)
```

## Notes pour le TP

- L'application enregistre **automatiquement** chaque requête GET
- Les logs sont stockés **en mémoire** (pour le développement)
- Pour une production, considérez une base de données (MongoDB, PostgreSQL, etc.)
- Le rafraîchissement automatique aide à voir les logs en temps réel

## Troubleshooting

### L'application ne démarre pas
```bash
# Vérifier que Node.js est installé
node --version

# Vérifier les dépendances
npm install

# Relancer
npm start
```

### Pas de logs qui s'affichent
- Vérifier que le serveur est en cours d'exécution
- Ouvrir la console de développement (F12)
- Vérifier les erreurs réseau

### Erreur lors du déploiement Azure
- Vérifier que `web.config` est present
- Vérifier que `package.json` existe et est valide
- Vérifier les logs d'Azure: `az webapp log tail --name webapp-cloud-lab --resource-group <votre-groupe>`

## License

MIT

