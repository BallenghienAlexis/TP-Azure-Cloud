# ✅ DÉPLOIEMENT SIMPLIFIÉ - PUBLISH PROFILE

## 3 ÉTAPES SIMPLES POUR FAIRE FONCTIONNER LE DÉPLOIEMENT

### ÉTAPE 1️⃣ : Télécharger le Publish Profile (2 minutes)

1. Ouvrez Azure Portal : https://portal.azure.com
2. Cherchez **webapp-cloud-lab** (votre App Service)
3. Cliquez dessus
4. En haut à droite, cliquez sur **Télécharger le profil de publication**
5. Un fichier `.PublishSettings` sera téléchargé (ex: webapp-cloud-lab.PublishSettings)

### ÉTAPE 2️⃣ : Ajouter le secret sur GitHub (2 minutes)

1. Allez sur GitHub : https://github.com/BallenghienAlexis/TP-Azure-Cloud
2. Cliquez sur **Settings** (en haut)
3. Menu à gauche : **Secrets and variables** → **Actions**
4. Cliquez sur **New repository secret**
5. Remplissez :
   - **Name** : `AZURE_WEBAPP_PUBLISH_PROFILE`
   - **Secret** : Ouvrez le fichier `.PublishSettings` téléchargé, copiez TOUT le contenu, collez-le ici
6. Cliquez **Add secret**

### ÉTAPE 3️⃣ : Déclencher le déploiement (1 minute)

Lancez un nouveau déploiement avec cette commande :

```powershell
cd "C:\Users\alexi\OneDrive - Emineo Education\Master\Cloud\cloud_azure"
git commit --allow-empty -m "Trigger deployment avec Publish Profile"
git push github master
```

## ✅ VÉRIFIER LE DÉPLOIEMENT

Allez sur : https://github.com/BallenghienAlexis/TP-Azure-Cloud/actions

Attendez quelques secondes, vous devriez voir le workflow en cours d'exécution :
- 🟡 **In progress** = En cours (5-7 minutes)
- 🟢 **Success** = Succès ! Application déployée
- 🔴 **Failed** = Regardez les logs

## 🌐 ACCÉDER À VOTRE APPLICATION

Une fois le déploiement réussi, allez à :
```
https://webapp-cloud-lab.azurewebsites.net
```

Vous devriez voir votre interface Vue.js avec :
- Le titre "Cloud Lab - Enregistreur de Requêtes GET"
- Les boutons de contrôle
- Un tableau pour les logs

## ⚠️ NOTES IMPORTANTES

- Le fichier `.PublishSettings` contient des secrets - **ne le partagez pas**
- GitHub chiffre le secret automatiquement
- Seul le workflow peut y accéder
- C'est beaucoup plus simple que les credentials AD

## 🚀 C'EST TOUT !

Plus besoin de credentials Azure complexes. Le Publish Profile suffit ! 🎉

