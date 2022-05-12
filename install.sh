#!/bin/bash
echo "Installing Gradle..."
wget -qq https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp
unzip -qq -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip
echo "Setting up Gradle environment..."
ln -s /opt/gradle/gradle-6.5.1 /opt/gradle/latest
echo "export GRADLE_HOME=${GRADLE_HOME_VAR}" >> /etc/profile.d/gradle.sh
echo "export PATH=${PATH}" >> /etc/profile.d/gradle.sh
chmod +x /etc/profile.d/gradle.sh
. /etc/profile.d/gradle.sh
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