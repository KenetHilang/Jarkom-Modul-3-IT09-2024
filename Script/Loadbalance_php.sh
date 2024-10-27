echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install lynx nginx php7.3 php-fpm apache2-utils -y

service php7.3-fpm start
service nginx start

rm -rf /etc/nginx/sites-available/*

echo 'upstream roundrobin {
    server 10.68.2.2;
    server 10.68.2.3;
    server 10.68.2.4;
}

upstream leastconnect {
    least_conn;
    server 10.68.2.2;
    server 10.68.2.3;
    server 10.68.2.4;
}

upstream iphash {
    ip_hash;
    server 10.68.2.2;
    server 10.68.2.3;
    server 10.68.2.4;
}

upstream genhash {
    hash $request_uri consistent;
    server 10.68.2.2;
    server 10.68.2.3;
    server 10.68.2.4;
}

server {
    listen 80;
    server_name _;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.html;

    location / {
        # Nomer 12
        allow 10.68.1.77;
		allow 10.68.1.88;
		allow 10.68.2.144;
		allow 10.68.2.156;
        deny all;
        # Nomer 10
    	auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_pass http://roundrobin;
    }

	location /leastconnect {
    # Nomer 10
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_pass http://leastconnect;
    }

    location /iphash {
    # Nomer 10
    	auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_pass http://iphash;
    }

    location /genhash {
    # Nomer 10
    	auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/supersecret/htpasswd;
        proxy_pass http://genhash;
    }

    # Nomer 10
    location /titan {
		proxy_pass https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki/;
    }
}' > /etc/nginx/sites-available/load-balancer-it09

ln -s /etc/nginx/sites-available/load-balancer-it09 /etc/nginx/sites-enabled

service nginx restart
service php7.3-fpm restart

mkdir -p /etc/nginx/supersecret
htpasswd -cb /etc/nginx/supersecret/htpasswd arminannie jrkmit09