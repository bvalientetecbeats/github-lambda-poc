FROM ubuntu:20.04
WORKDIR /home/ubuntu
COPY install.sh .
RUN ["/bin/sh", "./install.sh"]