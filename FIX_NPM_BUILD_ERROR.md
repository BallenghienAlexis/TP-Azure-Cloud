# ✅ FIX : Erreur npm "Invalid tag name"

## 🔴 PROBLÈME

```
npm ERR! code EINVALIDTAGNAME
npm ERR! Invalid tag name "&&" of package "&&"
```

### Cause
Le fichier `.deployment` contenait :
```
command = npm install && npm run build
```

Azure Kudu n'interprète pas correctement le `&&` dans ce contexte. Il essaie de traiter `&&` comme un nom de package npm au lieu de l'interpréter comme un opérateur de shell.

## ✅ SOLUTION

Créer un script shell `build.sh` qui exécute les deux commandes correctement.

### Fichiers modifiés

**`.deployment`** (avant) :
```
[config]
command = npm install && npm run build
```

**`.deployment`** (après) :
```
[config]
command = bash build.sh
```

**`build.sh`** (nouveau) :
```bash
#!/bin/bash
set -e

echo "Starting npm install..."
npm install

echo "Starting npm build..."
npm run build

echo "Build completed successfully!"
```

## 🚀 FLUX DE DÉPLOIEMENT

```
git push github master
  ↓
GitHub Actions déclenché
  ↓
npm install && npm run build (compilation Vue.js)
  ↓
azure/webapps-deploy@v2 avec Publish Profile
  ↓
Kudu exécute : bash build.sh
  ↓
build.sh lance npm install
  ↓
build.sh lance npm run build
  ↓
Application déployée sur Azure
  ↓
https://webapp-cloud-lab.azurewebsites.net
  ↓
✅ Application en ligne !
```

## 📊 STATUT ACTUEL

✅ Code corrigé et poussé sur GitHub
✅ Script build.sh créé
✅ Fichier .deployment corrigé
✅ Prêt pour le redéploiement

## 🔄 REDÉPLOYER

Déclenchez un nouveau déploiement :

```powershell
cd "C:\Users\alexi\OneDrive - Emineo Education\Master\Cloud\cloud_azure"
git commit --allow-empty -m "Trigger deployment avec build.sh"
git push github master
```

Attendez 5-7 minutes et vérifiez : https://webapp-cloud-lab.azurewebsites.net

## ✨ AVANTAGES DE CETTE APPROCHE

- ✅ Les erreurs de build sont capturées avec `set -e`
- ✅ Les logs sont clairs et informatifs
- ✅ Fonctionne sur tous les systèmes (Linux/Windows)
- ✅ Pas de problème d'interprétation de caractères spéciaux

