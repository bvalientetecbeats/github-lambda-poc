FROM benjaminvaliente/cicdtools:latest

WORKDIR /home/ubuntu

COPY gradle.sh .

ENV DEBIAN_FRONTEND=noninteractive
ENV GRADLE_VERSION=7.3.3
ENV GRADLE_HOME_VAR=/opt/gradle/latest
ENV PATH=$PATH:$GRADLE_HOME_VAR/bin

RUN ln -fs /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
RUN apt-get -qq update -y && apt-get -qq install -y unzip wget openjdk-11-jdk
#RUN ["/bin/sh", "./gradle.sh"]