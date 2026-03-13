# Script de déploiement pour Azure (PowerShell)

Write-Host "=== Deploiement Cloud Lab sur Azure ===" -ForegroundColor Green

# Vérifier que Git est configuré
try {
    git rev-parse --git-dir 2>$null | Out-Null
} catch {
    Write-Host "Initialisation du dépôt Git..." -ForegroundColor Yellow
    git init
    git config user.email "deployer@cloud-lab.com"
    git config user.name "Cloud Lab Deployer"
}

# Vérifier si le remote Azure existe
$remoteExists = $false
try {
    git remote get-url azure 2>$null | Out-Null
    $remoteExists = $true
} catch {}

if (-not $remoteExists) {
    Write-Host "Ajout du remote Azure..." -ForegroundColor Yellow
    git remote add azure "https://webapp-cloud-lab-fphxbwa7f8ejhzau.scm.francecentral-01.azurewebsites.net:443/webapp-cloud-lab.git"
}

# Ajouter tous les fichiers
Write-Host "Préparation des fichiers..." -ForegroundColor Yellow
git add -A

# Créer un commit
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
try {
    git commit -m "Deploiement Cloud Lab - $timestamp" 2>$null | Out-Null
    Write-Host "Commit créé" -ForegroundColor Green
} catch {
    Write-Host "Aucun changement à commiter" -ForegroundColor Gray
}

# Pousser vers Azure
Write-Host "Envoi vers Azure..." -ForegroundColor Yellow
try {
    git push azure main 2>$null
} catch {
    try {
        git push azure master 2>$null
    } catch {
        Write-Host "Erreur lors du push. Vérifiez vos credentials Azure." -ForegroundColor Red
        Write-Host "Utilisez: git credential approve" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "=== Deploiement terminé ===" -ForegroundColor Green
Write-Host "Accédez à votre application: https://webapp-cloud-lab.azurewebsites.net" -ForegroundColor Cyan

