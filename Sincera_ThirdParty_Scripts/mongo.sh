
#!/bin/bash
set -x
echo '[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7Server/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc ' >/etc/yum.repos.d/mongodb.repo

yum install mongodb-org -y
sleep 3


systemctl start mongod.service

systemctl enable mongod.service

mongod --version

echo "MongoDB installed"

