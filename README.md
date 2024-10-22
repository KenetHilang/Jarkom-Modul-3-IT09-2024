# Jarkom-Modul-3-IT09-2024

## Angggota

| Anggota | NRP  |
| ------- | --- |
| Michael Kenneth Salim | 5027231008 |
| Tio Axelino | 5027231065 |

## Network Config

### Paradis (Router)
```sh
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 10.68.1.1
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 10.68.2.1
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 10.68.3.1
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 10.68.4.1
	netmask 255.255.255.0
```
### Fritz (DNS Server)
```sh
auto eth0
iface eth0 inet static
	address 10.68.4.2
	netmask 255.255.255.0
	gateway 10.68.4.1
```


### Tybur (DHCP Server)
```sh
auto eth0
iface eth0 inet static
	address 10.68.4.3
	netmask 255.255.255.0
	gateway 10.68.4.1
```

### Beast (Load Balancer - Laravel)
```sh
auto eth0
iface eth0 inet static
	address 10.68.2.2
	netmask 255.255.255.0
	gateway 10.68.2.1
```

### Colossal (Load Balancer - PHP)
```sh
auto eth0
iface eth0 inet static
	address 10.68.2.3
	netmask 255.255.255.0
	gateway 10.68.2.1
```

### Warhammer (Database Server)
```sh
auto eth0
iface eth0 inet static
	address 10.68.2.4
	netmask 255.255.255.0
	gateway 10.68.2.1
```

### Annie (Laravel Worker)
```sh
auto eth0
iface eth0 inet static
	address 10.68.1.2
	netmask 255.255.255.0
	gateway 10.68.1.1
```

### Bertholdt (Laravel Worker)
```sh
auto eth0
iface eth0 inet static
	address 10.68.1.3
	netmask 255.255.255.0
	gateway 10.68.1.1
```

### Reiner (Laravel Worker)
```sh
auto eth0
iface eth0 inet static
	address 10.68.1.4
	netmask 255.255.255.0
	gateway 10.68.1.1
```

### Armin (PHP Worker)
```sh
auto eth0
iface eth0 inet static
	address 10.68.2.2
	netmask 255.255.255.0
	gateway 10.68.2.1
```

### Eren (PHP Worker)
```sh
auto eth0
iface eth0 inet static
	address 10.68.2.3
	netmask 255.255.255.0
	gateway 10.68.2.1
```

### Mikasa (PHP Worker)
```sh
auto eth0
iface eth0 inet static
	address 10.68.2.4
	netmask 255.255.255.0
	gateway 10.68.2.1
```

### Zeke (Client - Dynamic)
```sh
auto eth0
iface eth0 inet dhcp
```

### Erwin (Client - Dynamic)
```sh
auto eth0
iface eth0 inet dhcp
```

---
