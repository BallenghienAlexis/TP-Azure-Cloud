#!/bin/bash
# Script de déploiement pour Azure

echo "=== Déploiement Cloud Lab sur Azure ==="

# Vérifier que Git est configuré
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Initialisation du dépôt Git..."
    git init
    git config user.email "deployer@cloud-lab.com"
    git config user.name "Cloud Lab Deployer"
fi

# Vérifier si le remote Azure existe
if ! git remote get-url azure > /dev/null 2>&1; then
    echo "Ajout du remote Azure..."
    git remote add azure "https://webapp-cloud-lab-fphxbwa7f8ejhzau.scm.francecentral-01.azurewebsites.net:443/webapp-cloud-lab.git"
fi

# Ajouter tous les fichiers
echo "Préparation des fichiers..."
git add -A

# Créer un commit
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
git commit -m "Déploiement Cloud Lab - $TIMESTAMP" || echo "Aucun changement à commiter"

# Pousser vers Azure
echo "Envoi vers Azure..."
git push azure main 2>/dev/null || git push azure master

echo "=== Déploiement terminé ==="
echo "Accédez à votre application: https://webapp-cloud-lab.azurewebsites.net"

