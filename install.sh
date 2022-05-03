#!/bin/bash
echo "Configuring time zone..."
ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
echo "Installing dependencies..."
DEBIAN_FRONTEND=noninteractive
apt-get -qq update -y > /dev/null 2>&1 && apt-get install -y unzip wget zip git-all curl > /dev/null 2>&1
echo "Configuring terraform 1.1.9..."
wget https://releases.hashicorp.com/terraform/1.1.9/terraform_1.1.9_linux_amd64.zip
unzip -qq terraform_1.1.9_linux_amd64.zip && mv terraform /usr/local/bin/
echo "Configuring AWS CLI 2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -qq awscliv2.zip
./aws/install
echo "Installing AWS SAM..."
wget https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip
unzip aws-sam-cli-linux-x86_64.zip -d sam-installation
./sam-installation/install
echo "Installing nodejs 14.x..."
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
rm -rf /home/ubuntu/*
apt remove -y unzip wget zip curl > /dev/null 2>&1
apt clean