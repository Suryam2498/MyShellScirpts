#!/bin/bash


mysql -uroot -pmanager1! < create_db_user_test.sql

echo "New user and database are created"


echo "Login With new user"

mysql -uniceuser1 -pNicepw@1 < login_new_user.sql

echo "Tables are created "

echo "***********************"

