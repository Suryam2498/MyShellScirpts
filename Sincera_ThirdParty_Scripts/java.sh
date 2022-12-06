#!/bin/bash
sudo yum install wget -y
#Installing Java

java_buildversion="131"

java -version

if [[ $(echo $?) -eq 0 ]]
then
   echo "Java alreday Installed "
   exit 0
else
  sudo mkdir /usr/jdk
  cd /usr/jdk/
  wget --header 'Cookie: oraclelicense=a' http://download.oracle.com/otn-pub/java/jdk/8u${java_buildversion}-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u${java_buildversion}-linux-x64.tar.gz
  sudo tar -xvf jdk-8u${java_buildversion}-linux-x64.tar.gz
  sudo alternatives --install /usr/bin/java java /usr/jdk/jdk1.8.0_${java_buildversion}/bin/java 1
fi

 #echo -e "\n"
#echo -e "\n"

#if [[ $(which java) == "/bin/java" ]]
 #then
  # echo -e "Java has been successfully installed in the machine\n"
   #sudo java -version
#else
 #  echo "Failed to install Java"
#fi
