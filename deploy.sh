#!/bin/bash
set -e

echo "Atualizando o orquestrador Docker..."

cd ~/ifsports
git checkout master
git pull origin master

echo "Atualizando o frontend"
cd ~/ifsports/frontend-ifsports
git pull origin main

echo "Atualizando microserviços..."

echo "Atualizando o auth-service..."
cd ~/ifsports/auth_service_back
git pull origin master

echo "Atualizando o audit-service..."
cd ~/ifsports/audit_service
git pull origin master

echo "Atualizando o calendar-service..."
cd ~/ifsports/calendar-service
git pull origin main

echo "Atualizando o competitions-service..."
cd ~/ifsports/competitions-service
git pull origin main

echo "Atualizando o match-comments-service..."
cd ~/ifsports/match-comments-service
git pull origin master

echo "Atualizando o requests-service..."
cd ~/ifsports/requests_service
git pull origin master

echo "Atualizando o teams-service..."
cd ~/ifsports/teams_service
git pull origin master

cd ~/ifsports

echo "Subindo os contêineres com Docker Compose..."

echo "Subindo Microserviços..."
docker-compose up -d --build

echo "Subindo Serviços de Backup..."
docker-compose -f docker-compose.backup.yml up -d --build

echo "Subindo Serviços de Monitoramento..."
docker-compose -f monitoring/docker-compose.monitoring.yml up -d --build

echo "Limpando imagens Docker antigas..."
docker image prune -af

echo "Deploy concluído com sucesso!"