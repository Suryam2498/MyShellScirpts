#!/bin/bash
sudo apt-get install wget -y
#Installing Java

java -version

if [[ $(echo $?) -eq 0 ]]
then
   echo "Java alreday Installed "
   exit 0
else
  sudo apt-get update
  sudo apt-get install default-jre -y
fi

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
docker info


wget https://get.jenkins.io/war/2.380/jenkins.war
java -jar jenkins.war


