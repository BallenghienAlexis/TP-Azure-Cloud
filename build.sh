#!/bin/bash
# Script de build pour Azure Kudu
set -e

echo "Starting npm install..."
npm install

echo "Starting npm build..."
npm run build

echo "Build completed successfully!"

