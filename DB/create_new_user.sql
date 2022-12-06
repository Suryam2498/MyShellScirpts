CREATE USER 'niceuser1'@'localhost' IDENTIFIED BY 'Nicepw@1';

CREATE DATABASE nicedb1;
GRANT ALL PRIVILEGES ON nicedb1.* TO 'nice_user4'@'localhost' WITH GRANT OPTION;
\q