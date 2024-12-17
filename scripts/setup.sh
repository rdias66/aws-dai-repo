#!/bin/sh

# Atualizar pacotes existentes
echo "Atualizando pacotes existentes"
sudo apt update
sudo apt upgrade -y

# Adicionar usuário base
echo "Adicionando usuário base"
sudo adduser --gecos "" admin

# Adicionar usuário base ao grupo sudo
echo "Adicionando usuário base ao grupo sudo"
sudo usermod -a -G sudo admin

# Instalar pacotes base
echo "Instalando pacotes base"
sudo apt install -y htop git curl unzip jq

# Instalar Docker
echo "Instalando Docker"
sudo apt install -y \
    cron \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# Adicionar usuário base ao grupo Docker
echo "Adicionando usuário base ao grupo Docker"
sudo usermod -a -G docker admin

# Criar redes Docker
echo "Criando redes Docker"
sudo docker network create backend
sudo docker network create frontend

# Instalar AWS CLI
echo "Instalando AWS CLI"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

# Configurar credenciais da AWS
echo "Configurando credenciais da AWS"
aws configure
