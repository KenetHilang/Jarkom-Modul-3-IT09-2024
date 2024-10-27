echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install lynx nginx wget unzip php7.3 php7.3-fpm -y

service php7.3-fpm start
service nginx start

mkdir -p /var/www/html/download/

wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1TvebIeMQjRjFURKVtA32lO9aL7U2msd6' -O /var/www/html/download/eldia.zip

unzip /var/www/html/download/eldia.zip -d /var/www/eldia.it09.com

rm -rf /var/www/html/download/

echo '
server {
	listen 80;
	server_name eldia.it09.com;

	root /var/www/eldia.it09.com;

	index index.php index.html index.htm;

	server_name _;

	location / {
		try_files \$uri \$uri/ /index.php?\$query_string;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.3-fpm.sock;
	}

	error_log /var/log/nginx/jarkom-it09_error.log;
	access_log /var/log/nginx/jarkom-it09_access.log;
}' > /etc/nginx/sites-available/eldia.it09.com

ln -s /etc/nginx/sites-available/eldia.it09.com /etc/nginx/sites-enabled

rm -rf /etc/nginx/sites-enabled/default

service php7.3-fpm start
service php7.3-fpm restart
service nginx restart
nginx -t