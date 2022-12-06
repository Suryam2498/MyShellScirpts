#!/bin/bash
#SET -x
#Installation Python
yum install make wget -y >/dev/null

which python3.7 >/dev/null 2>&1
if [[ $? -eq 0 ]]
then
   echo "$(python3.7 -V) is alreday installed in the machine"
   exit 0
else
echo "Please wait while it is installing these could take sometime..."
version=3.7.9
cd /opt

##wet https://www.python.org/ftp/python/3.7.9/Python-3.7.9.tgz

wget https://www.python.org/ftp/python/${version}/Python-${version}.tgz
tar xzf Python-${version}.tgz
yum install gcc openssl-devel bzip2-devel libffi-devel zlib-devel -y > /dev/null
sleep 5
echo "Still in progress"
cd Python-${version}
./configure --enable-optimizations
make altinstall
cat << EOF >> /etc/profile

export PATH=/usr/local/bin:${PATH}

EOF

#source ~/.bashrc
. /etc/profile

echo -e "$(python3.7 -V) has been installed successfully"\n
fi

# we should run the source /etc/profile  (or) . /etc/profile manually

