echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install -y bind9 bind9utils bind9-doc dnsutils

service bind9 start

mkdir /etc/bind/it09

echo 'zone "marley.it09.com" {
    type master;
    file "/etc/bind/it09/marley.it09.com";
};

zone "eldia.it09.com" {
    type master;
    file "/etc/bind/it09/eldia.it09.com";
};' > /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/it09/marley.it09.com
cp /etc/bind/db.local /etc/bind/it09/eldia.it09.com

echo '$TTL    604800
@       IN      SOA     marley.it09.com. root.marley.it09.com. (
                        2				; Serial
                        604800			; Refresh
                        86400			; Retry
                        2419200         ; Expire
                        604800 )		; Negative Cache TTL
;
@       IN  NS      marley.it09.com.
@       IN  A       10.68.1.2
www     IN  CNAME   marley.it09.com.' > /etc/bind/it09/marley.it09.com

echo '$TTL    604800
@       IN      SOA     eldia.it09.com. root.eldia.it09.com. (
                        2				; Serial
                        604800			; Refresh
                        86400			; Retry
                        2419200         ; Expire
                        604800 )		; Negative Cache TTL
;
@       IN  NS      eldia.it09.com.
@       IN  A       10.68.2.2
www     IN  CNAME   eldia.it09.com.' > /etc/bind/it09/eldia.it09.com

service bind9 restart
