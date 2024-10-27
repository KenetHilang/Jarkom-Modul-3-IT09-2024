echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install isc-dhcp-server -y

service isc-dhcp-server start

echo 'INTERFACES="eth0"' > /etc/default/isc-dhcp-server

#Client yang melalui bangsa marley mendapatkan range IP dari [prefix IP].1.05 - [prefix IP].1.25 dan [prefix IP].1.50 - [prefix IP].1.100 (2)

#Client yang melalui bangsa eldia mendapatkan range IP dari [prefix IP].2.09 - [prefix IP].2.27 dan [prefix IP].2 .81 - [prefix IP].2.243 (3)


echo 'subnet 10.68.1.0 netmask 255.255.255.0 {
    range 10.68.1.05 10.68.1.25;
    range 10.68.1.50 10.68.1.100;
	option routers 10.68.1.1;
	option broadcast-address 10.68.1.255;
	option domain-name-servers 10.68.4.2;
	default-lease-time 1800;
    max-lease-time 5220;
}

subnet 10.68.2.0 netmask 255.255.255.0 {
    range 10.68.2.09 10.68.2.27;
    range 10.68.2.81 10.68.2.243;
	option routers 10.68.2.1;
	option broadcast-address 10.68.2.255;
	option domain-name-servers 10.68.4.2;
	default-lease-time 360;
    max-lease-time 5220;
}

subnet 10.68.3.0 netmask 255.255.255.0 {}

subnet 10.68.4.0 netmask 255.255.255.0 {}' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart
