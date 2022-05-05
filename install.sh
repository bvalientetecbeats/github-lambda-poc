#!/bin/bash
echo "Configuring time zone..."
ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
echo "Installing dependencies..."
DEBIAN_FRONTEND=noninteractive
GRADLE_VERSION=6.5.1
GRADLE_HOME_VAR=/opt/gradle/latest
apt-get -qq update -y && apt-get install -y unzip wget zip git-all curl openjdk-11-jdk
echo "Installing Gradle..."
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp
unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-bin.zip
echo "Setting up Gradle environment..."
ln -s /opt/gradle/gradle-${GRADLE_VERSION} /opt/gradle/latest
echo "export GRADLE_HOME=/opt/gradle/latest" >> /etc/profile.d/gradle.sh
echo "export PATH=${GRADLE_HOME_VAR}/bin:${PATH}" >> /etc/profile.d/gradle.sh
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