FROM openjdk:8u302-jre-buster
#FROM openjdk:8u191-jre-alpine3.8

RUN apt-get update
RUN apt-get install curl
RUN apt-get -y install jq -y
RUN apt-get install dos2unix

# Workspace
WORKDIR /usr/share/udemy

# Add .jar under target from host into the image
ADD target/selenium-docker.jar selenium-docker.jar 
ADD target/selenium-docker-tests.jar selenium-docker-tests.jar
ADD target/libs libs

# Add suite files
ADD book-flight-module.xml book-flight-module.xml
ADD search-module.xml search-module.xml

# Add healthcheck script
ADD healthcheck.sh healthcheck.sh
RUN dos2unix healthcheck.sh

# BROWSER
# HUB_HOST
# MODULE
ENTRYPOINT sh healthcheck.sh