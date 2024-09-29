#!/bin/bash
cd ~
mkdir -pv configs
mkdir -pv docker_volumes
mkdir -pv docker_volumes/elasticsearch
mkdir -pv configs/elasticsearch
mkdir -pv configs/filebeat
mkdir -pv configs/kibana
mkdir -pv configs/logstash
mkdir -pv configs/logstash/pipelines

sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Добавление репозитория Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo chmod +x /home/freddy/docker-compose.yml
sudo apt update
sudo apt install -y nginx
sudo chmod 777 /var/log/nginx/access.log
sudo curl localhost
sudo docker compose -f ~/docker-compose.yml up -d