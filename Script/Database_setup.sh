#!/bin/bash

echo "nameserver 192.168.122.1" > /etc/resolv.conf

apt-get update
apt-get install -y mariadb-server

service mysql start

mysql -u root <<EOF
CREATE USER 'kelompokit09'@'%' IDENTIFIED BY 'passwordit09';
CREATE USER 'kelompokit09'@'localhost' IDENTIFIED BY 'passwordit09';
CREATE DATABASE dbkelompokit09;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit09'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit09'@'localhost';
FLUSH PRIVILEGES;
EOF

echo '[mysqld]
skip-networking=0
skip-bind-address' > /etc/mysql/my.cnf


echo "MariaDB setup completed."
