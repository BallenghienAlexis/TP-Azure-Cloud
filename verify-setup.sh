#!/bin/bash
# Script de vérification pré-déploiement
echo "🔍 Vérification de la configuration..."
echo ""

# Vérification des fichiers essentiels
check_file() {
    if [ -f "$1" ]; then
        echo "✓ $1"
    else
        echo "✗ $1 (MANQUANT)"
    fi
}

echo "📦 Fichiers essentiels:"
check_file "server.js"
check_file "package.json"
check_file "web.config"
check_file "index.html"

echo ""
echo "📁 Répertoires:"
[ -d "dist" ] && echo "✓ dist/" || echo "✗ dist/ (MANQUANT)"
[ -d "src" ] && echo "✓ src/" || echo "✗ src/ (MANQUANT)"
[ -d "node_modules" ] && echo "✓ node_modules/" || echo "✗ node_modules/ (À installer)"
[ -d ".git" ] && echo "✓ .git/" || echo "✗ .git/ (À initialiser)"

echo ""
echo "🔗 Configuration Git:"
if [ -d ".git" ]; then
    if git remote get-url azure >/dev/null 2>&1; then
        echo "✓ Remote 'azure' configuré"
        git remote get-url azure
    else
        echo "✗ Remote 'azure' non configuré"
    fi
fi

echo ""
echo "📋 Commits:"
if [ -d ".git" ]; then
    COUNT=$(git rev-list --count HEAD 2>/dev/null)
    echo "✓ $COUNT commit(s) présent(s)"
fi

echo ""
echo "🎉 Vérification terminée!"

