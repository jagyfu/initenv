# initenv



## install bbr 
```
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
## check media unlock
```
bash <(curl -sSL "https://github.com/CoiaPrant/MediaUnlock_Test/raw/main/check.sh")
// 两个都可
bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
```
## dd ros
```
bash <(curl -sSL "https://raw.githubusercontent.com/jagyfu/initenv/main/ddros.sh")
```
## dd sys
```
bash <(curl -sSL "https://raw.githubusercontent.com/jagyfu/initenv/main/dd-sys.sh")
```
## install l2tp ipsec 
## https://github.com/hwdsl2/setup-ipsec-vpn
centos
```
wget https://git.io/vpnsetup-centos -O vpn.sh && sudo sh vpn.sh && sudo bash /opt/src/ikev2.sh --auto
```
debian
```
wget https://git.io/vpnsetup -O vpn.sh && sudo sh vpn.sh && sudo bash /opt/src/ikev2.sh --auto
```

## test return route
```
curl http://tutu.ovh/bash/returnroute/test.sh|bash
```

## install docker to centos
```
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
yum install docker-ce docker-ce-cli containerd.io
systemctl start docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

## install ros docker
https://github.com/EvilFreelancer/docker-routeros
```
git clone https://github.com/EvilFreelancer/docker-routeros.git
cd docker-routeros
docker build . --tag ros
## docker run --cap-add NET_ADMIN --device /dev/net/tun  -d -p 2222:22 -p 2280:80 -p 8291:8291 -p 1701:1701/udp -p 500:500/udp -p 4500:4500/udp -p 5900:5900 -ti evilfreelancer/docker-routeros
docker run --cap-add NET_ADMIN --device /dev/net/tun  -d -p 2222:22 -p 2280:80 -p 8291:8291 -p 1701:1701/udp -p 500:500/udp -p 4500:4500/udp -p 5900:5900 -ti ros
```
