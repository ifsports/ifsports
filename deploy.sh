#!/bin/bash
set -e

echo "Atualizando o orquestrador Docker..."

cd ~/ifsports
git checkout master
git pull origin master

echo "Atualizando o frontend"
cd frontend-ifsports
git pull origin main
cd ..

echo "Atualizando microserviços..."

echo "Atualizando o auth-service..."
cd ~/ifsports/auth_service_back/   
git pull origin master


echo "Atualizando o audit-service..."
cd audit_service
git pull origin master
cd ..

echo "Atualizando o calendar-service..."
cd calendar-service
git pull origin main
cd ..

echo "Atualizando o competitions-service..."
cd competitions-service
git pull origin main
cd ..

echo "Atualizando o match-comments-service..."
cd match-comments-service
git pull origin master
cd ..

echo "Atualizando o requests-service..."
cd requests_service
git pull origin master
cd ..

echo "Atualizando o teams-service..."
cd teams_service
git pull origin master
cd ..

echo "Subindo os contêineres com Docker Compose..."
docker-compose up --build -d --remove-orphans

echo "Limpando imagens Docker antigas..."
docker image prune -af

echo "Deploy concluído com sucesso!"