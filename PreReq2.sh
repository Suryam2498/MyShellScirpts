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

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -y
sudo apt install jenkins -y 
sudo systemctl start jenkins.service

echo " Jenkins Service Started"



