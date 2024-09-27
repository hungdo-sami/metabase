#!/bin/bash

# Cập nhật hệ thống
sudo apt update

# Cài đặt Git
sudo apt install -y git

# Cài đặt Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
sudo systemctl start docker
sudo systemctl enable docker

# Kiểm tra phiên bản Docker
docker --version

# Cài đặt Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Kiểm tra phiên bản Docker Compose
docker-compose --version

echo "Cài đặt hoàn tất!"
