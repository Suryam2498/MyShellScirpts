

#!/bin/bash
#set -x
passcode="test"

useradd mysql
sudo echo ${passcode} | passwd "mysql" --stdin
echo "mysql ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# This script needs to be run from mysql user only
mysql_rpm=https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm

yum install -y wget

wget ${mysql_rpm}

if [[ $? -ne 0 ]]
then
echo "RPM installtion got faileed"
exit 1
fi

yum localinstall ${mysql_rpm} <<< y
yum -y module disable mysql
yum -y install mysql-community-server
echo "lower_case_table_names=1" >> /etc/my.cnf
#mysqld --defaults-file=/etc/my.cnf --initialize --lower_case_table_names=1 --user=mysql --console
service mysqld start
tmp_pass=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
echo ${tmp_pass}
mysql -u root -p"$tmp_pass" --connect-expired-password < command.sql
echo "Completed"
