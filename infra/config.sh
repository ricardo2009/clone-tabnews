#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y build-essential
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt install dnsutils -y 
sudo apt install net-tools -y


## comando para executar os testes
#npm run test:watch

## comando executar o projeto
#npm run dev

## Instalar o Docker
  #docker compose down --remove-orphans --volumes --rmi all 
  #docker-compose down 
  #docker compose up -f infra/compose.yml -d --build --force-recreate
## instalar o DIG
  sudo apt-get install dnsutils -y
  sudo apt update -y

# Criar uma ba
#npm install pg@8.11.3 # ELE que vai se comunicar com postgres
sudo apt install postgresql-client -y
#psql 
#psql --host=localhost --username=postgres --port=5432
#docker compose -f infra/compose.yml up -d 