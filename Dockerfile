FROM ubuntu:20.04

WORKDIR /home/ubuntu

COPY install.sh /home/ubuntu/
RUN ./install.sh