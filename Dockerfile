FROM gradle:latest

WORKDIR /home/gradle

COPY install.sh /home/gradle/
RUN ./install.sh