#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y build-essential
sudo apt-get install -y curl
sudo apt-get install -y wget
sudo apt install dnsutils -y 
sudo apt install net-tools -y



#docker compose up
#docker-compose up -d --build --force-recreate

sudo apt update -y
sudo apt install postgresql-client -y
#psql 
#psql --host=localhost --username=postgres --port=5432
#docker compose -f infra/compose.yml up -d 