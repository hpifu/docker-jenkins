FROM jenkins/jenkins:2.191
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
USER ROOT
RUN apt-get update
RUN apt-get install build-essential
