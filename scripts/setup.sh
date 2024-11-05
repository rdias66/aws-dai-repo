#!/bin/sh
echo "Updating existing packages"
sudo apt update
sudo apt upgrade -y

echo "Adding base user"
sudo adduser admin


echo "Adding base user to sudo"
sudo usermod -a -G sudo admin


echo "Installing base packages"
sudo apt install -y htop git curl unzip jq

echo "Installing Docker"
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose


echo "Adding base users to Docker group"
sudo usermod -a -G docker admin

echo "Creating docker networks"
sudo docker network create backend
sudo docker network create frontend

echo "Installing AWS CLI"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

echo "Configuring AWS credentials"
aws configure
