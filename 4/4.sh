# Set up jenkins
# https://www.jenkins.io/doc/book/installing/docker/#setup-wizard

docker pull docker:dind
docker pull jenkins/jenkins:2.249.3-slim

docker network create jenkins
docker run --name jenkins-docker --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 docker:dind

# Create Dockerfile on different dir:
FROM jenkins/jenkins:2.249.3-slim
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins blueocean:1.24.3
docker build -t myjenkins-blueocean:1.1 .


docker run --name jenkins-blueocean --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:1.1


# Go to 192.168.56.102:8080/

# Startup settings:
docker logs -f jenkins-blueocean
# insert password
# on jenkins site: getting started

# On 2nd VM agent goes
# install maven, create user

apt-get update && apt-get install openjdk-8-jdk git maven
groupadd jenkins
useradd -d /home/jenkins -m -r -s /bin/bash -g jenkins Jenkins

su -l Jenkins

# On user jenkins copy root authorized_keys to dir .ssh

chown jenkins:jenkins authorized_keys

# On dir /etc/sudoers add str:
Jenkins ALL=(ALL) NOPASSWD: ALL
# for do not use sudo and password


# Create agent
# Adde private key of VM where Jenkins intalled to 'Creidintals'

# Create pipeline
node('test-agent'){
	stage('install gcc and clone rep') {
	      sh 'sudo apt-get update'
		sh 'sudo apt-get install build-essential manpages-dev'
		sh 'gcc --version'
		sh 'sudo rm -rf SopoHw4'
		sh 'git clone https://github.com/danilapal/SopoHw4.git'
	}
	stage('compile gcc program'){
		sh 'cc SopoHw4/hw4.c -o SopoHw4/hw4'
	}
	stage('start code') {
		sh './SopoHw4/hw4'
	}
}

