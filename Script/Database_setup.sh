echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install mariadb-server -y

service mysql start

mysql -u root -p

CREATE USER 'kelompokit09'@'%' IDENTIFIED BY 'passwordit09';
CREATE USER 'kelompokit09'@'localhost' IDENTIFIED BY 'passwordit09';
CREATE DATABASE dbkelompokit09;
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit09'@'%';
GRANT ALL PRIVILEGES ON *.* TO 'kelompokit09'@'localhost';
FLUSH PRIVILEGES;

exit