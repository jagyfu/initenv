# initenv



## install bbr 
```
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
## check media unlock
```
bash <(curl -sSL "https://github.com/CoiaPrant/MediaUnlock_Test/raw/main/check.sh")
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
```

## install ros docker
https://github.com/EvilFreelancer/docker-routeros
```

```
