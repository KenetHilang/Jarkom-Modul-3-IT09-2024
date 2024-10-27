# Jarkom-Modul-3-IT09-2024

## Angggota

| Anggota | NRP  |
| ------- | --- |
| Michael Kenneth Salim | 5027231008 |
| Tio Axelino | 5027231065 |

## Topologi

![Topologi](image.png)


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

## Soal Nomer 0
Pulau Paradis telah menjadi tempat yang damai selama 1000 tahun, namun kedamaian tersebut tidak bertahan selamanya. Perang antara kaum Marley dan Eldia telah mencapai puncak. Kaum Marley yang dipimpin oleh Zeke, me-register domain name marley.yyy.com untuk worker Laravel mengarah pada Annie. Namun ternyata tidak hanya kaum Marley saja yang berinisiasi, kaum Eldia ternyata sudah mendaftarkan domain name eldia.yyy.com untuk worker PHP (0) mengarah pada Armin.

## Setup DNS pada Fritz (DNS Server)

a. Instalasi dependencies yang diperlukan

```sh
apt-get update
apt-get install bind9 -y
```

b. Menjalankan service dari bind9

```sh
service bind9 start
```

c. Menambahkan line berikut pada file `etc/bind/named.conf.local`

```sh
zone "marley.it09.com" {
    type master;
    file "/etc/bind/it09/marley.it09.com";
};

zone "eldia.it09.com" {
    type master;
    file "/etc/bind/it09/eldia.it09.com";
};
```

d. Membuat DNS record pada `/etc/bind/it09/marley.it09.com`

```sh
$TTL    604800
@       IN      SOA     marley.it09.com. root.marley.it09.com. (
                        2				; Serial
                        604800			; Refresh
                        86400			; Retry
                        2419200         ; Expire
                        604800 )		; Negative Cache TTL
;
@       IN  NS      marley.it09.com.
@       IN  A       10.68.1.2
www     IN  CNAME   marley.it09.com.
```

e. Membuat DNS record pada `/etc/bind/it09/eldia.it09.com`

```sh
$TTL    604800
@       IN      SOA     eldia.it09.com. root.eldia.it09.com. (
                        2				; Serial
                        604800			; Refresh
                        86400			; Retry
                        2419200         ; Expire
                        604800 )		; Negative Cache TTL
;
@       IN  NS      eldia.it09.com.
@       IN  A       10.68.2.2
www     IN  CNAME   eldia.it09.com.
```

f. Merestart service dari bind9

```sh
service bind9 restart
```



## Soal Nomer 1
Lakukan konfigurasi sesuai dengan peta yang sudah diberikan. Semua Client harus menggunakan konfigurasi ip address dari keluarga Tybur (dhcp).

### Setup DHCP Server (Tybur)

a. Instalasi dependencies yang diperlukan

```
apt-get update
apt-get install isc-dhcp-server -y
```

b. Menjalankan service dari isc-dhcp-server

```
service isc-dhcp-server start
```

c. Menambahkan line berikut pada file `/etc/default/isc-dhcp-server`

```
INTERFACES="eth0"
```

d. Menambahkan line berikut pada file `/etc/dhcp/dhcpd.conf`

```
subnet 10.68.1.0 netmask 255.255.255.0 {
	option routers 10.68.1.1;
	option broadcast-address 10.68.1.255;
	option domain-name-servers 10.68.4.2;
}

subnet 10.68.2.0 netmask 255.255.255.0 {
	option routers 10.68.2.1;
	option broadcast-address 10.68.2.255;
	option domain-name-servers 10.68.4.2;
}

subnet 10.68.3.0 netmask 255.255.255.0 {}

subnet 10.68.4.0 netmask 255.255.255.0 {}
```

e. Merestart service dari isc-dhcp-server

```
service isc-dhcp-server restart
```

### Setup DHCP Relay (Paradis)

a. Instalasi dependencies yang diperlukan

```
apt-get update
apt-get install isc-dhcp-relay -y
```

b. Menjalankan service dari isc-dhcp-relay

```
service isc-dhcp-relay start
```

c. Menambahkan line berikut pada file `/etc/default/isc-dhcp-relay`

```
SERVERS="10.68.4.3"
INTERFACES="eth1 eth2 eth3 eth4"
OPTIONS=""
```

d. Menambahkan line berikut pada file `/etc/sysctl.conf`

```
net.ipv4.ip_forward=1
```

e. Merestart service dari isc-dhcp-relay

```
service isc-dhcp-relay restart
```

f. Menampilkan status dari isc-dhcp-relay

```
service isc-dhcp-relay status
```


## Soal Nomer 2
Client yang melalui bangsa marley mendapatkan range IP dari [prefix IP].1.05 - [prefix IP].1.25 dan [prefix IP].1.50 - [prefix IP].1.100 (2)

## Soal Nomer 3
Client yang melalui bangsa eldia mendapatkan range IP dari [prefix IP].2.09 - [prefix IP].2.27 dan [prefix IP].2 .81 - [prefix IP].2.243 (3)

## Soal Nomer 4
Client mendapatkan DNS dari keluarga Fritz dan dapat terhubung dengan internet melalui DNS tersebut (4)

![Hasil Ping](image-1.png)
![Hasil Ping 2](image-2.png)

## Soal Nomer 5
Dikarenakan keluarga Tybur tidak menyukai kaum eldia, maka mereka hanya meminjamkan ip address ke kaum eldia selama 6 menit. Namun untuk kaum marley, keluarga Tybur meminjamkan ip address selama 30 menit. Waktu maksimal dialokasikan untuk peminjaman alamat IP selama 87 menit. (5)

![Hasil Erwin](image-3.png)
![Hasil Zeke](image-4.png)

## Soal Nomer 6
Armin berinisiasi untuk memerintahkan setiap worker PHP untuk melakukan konfigurasi virtual host untuk website berikut https://intip.in/BangsaEldia dengan menggunakan php 7.3 (6)

### Testing

#### Armin
```sh
lynx 10.68.2.2
```

![Armin](image-5.png)

#### Eren
```sh
lynx 10.68.2.3
```

![Eren](image-6.png)

#### Mikasa
```sh
lynx 10.68.2.4
```
![Mikasa](image-7.png)

## Soal Nomer 7
Dikarenakan Armin sudah mendapatkan kekuatan titan colossal, maka bantulah kaum eldia menggunakan colossal agar dapat bekerja sama dengan baik. Kemudian lakukan testing dengan 6000 request dan 200 request/second. (7)



## Soal Nomer 8
Karena Erwin meminta “laporan kerja Armin”, maka dari itu buatlah analisis hasil testing dengan 1000 request dan 75 request/second untuk masing-masing algoritma Load Balancer dengan ketentuan sebagai berikut:
- Nama Algoritma Load Balancer
- Report hasil testing pada Apache Benchmark
- Grafik request per second untuk masing masing algoritma
- Analisis (8)


## Soal Nomer 9
Dengan menggunakan algoritma Least-Connection, lakukan testing dengan menggunakan 3 worker, 2 worker, dan 1 worker sebanyak 1000 request dengan 10 request/second, kemudian tambahkan grafiknya pada “laporan kerja Armin”. (9)


## Soal Nomer 10
Selanjutnya coba tambahkan keamanan dengan konfigurasi autentikasi di Colossal dengan dengan kombinasi username: “arminannie” dan password: “jrkmyyy”, dengan yyy merupakan kode kelompok. Terakhir simpan file “htpasswd” nya di /etc/nginx/supersecret/ (10)

## Soal Nomer 11
Lalu buat untuk setiap request yang mengandung /titan akan di proxy passing menuju halaman https://attackontitan.fandom.com/wiki/Attack_on_Titan_Wiki (11) 
hint: (proxy_pass)

## Soal Nomer 12
Selanjutnya Colossal ini hanya boleh diakses oleh client dengan IP [Prefix IP].1.77, [Prefix IP].1.88, [Prefix IP].2.144, dan [Prefix IP].2.156. (12) 
hint: (fixed in dulu clientnya)

## Soal Nomer 13
Karena mengetahui bahwa ada keturunan marley yang mewarisi kekuatan titan, Zeke pun berinisiatif untuk menyimpan data data penting di Warhammer, dan semua data tersebut harus dapat diakses oleh anak buah kesayangannya, Annie, Reiner, dan Berthold.  (13)