#!/bin/sh

# Update existing packages
echo "Updating existing packages"
sudo apt update
sudo apt upgrade -y

# Add base user
echo "Adding base user"
sudo adduser --gecos "" admin

# Add base user to sudo
echo "Adding base user to sudo"
sudo usermod -a -G sudo admin

# Install base packages
echo "Installing base packages"
sudo apt install -y htop git curl unzip jq

# Install Docker
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
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose

# Add base user to Docker group
echo "Adding base user to Docker group"
sudo usermod -a -G docker admin

# Create Docker networks
echo "Creating Docker networks"
sudo docker network create backend
sudo docker network create frontend

# Setup cron jobs for cleanup scripts
echo "Setting up cron jobs for cleanup scripts"
CRON_FILE=$(mktemp)

# Update the file paths to match the admin user's folder structure
echo "0 0 * * 6 /home/admin/aws-deploy-assist-infra/clean-docker.sh >> /home/admin/aws-deploy-assist-infra/cleaner-logs/clean-docker.log 2>&1" >> $CRON_FILE
echo "0 0 * * 6 /home/admin/aws-deploy-assist-infra/clean-ecr.sh >> /home/admin/aws-deploy-assist-infra/cleaner-logs/clean-ecr.log 2>&1" >> $CRON_FILE

# Install the new crontab from the temporary file
sudo crontab $CRON_FILE

# Remove the temporary file
rm $CRON_FILE

echo "Cron jobs have been set up successfully."

sudo systemctl daemon-reload
sudo systemctl restart cron

# Install AWS CLI
echo "Installing AWS CLI"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install

# Configure AWS credentials
echo "Configuring AWS credentials"
aws configure
