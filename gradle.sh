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
gradle -v