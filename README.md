# initenv


## install soft
```
wget https://raw.githubusercontent.com/jagyfu/initenv/main/install.sh -O install.sh | sh install.sh
```

## install bbr 
```
wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
```
## check media unlock
```
bash <(curl -L -s check.unlock.media)

##bash <(curl -L -s https://raw.githubusercontent.com/lmc999/RegionRestrictionCheck/main/check.sh)
```
## dd ros
```
bash <(curl -sSL "https://raw.githubusercontent.com/jagyfu/initenv/main/ddros.sh")
```
## dd sys
```
bash <(curl -sSL "https://raw.githubusercontent.com/jagyfu/initenv/main/dd-sys.sh")
```

## install docker l2tp ipsec 
安装教程 https://github.com/hwdsl2/docker-ipsec-vpn-server/blob/master/README-zh.md

```
#安装docker
 sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
 sudo yum install -y yum-utils
 sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
 sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

   systemctl status docker
   systemctl enable docker
启动docker
   systemctl start docker
```
#安装
```
  docker run \
    --name ipsec-vpn-server \
    --restart=always \
     --env-file /root/vpn.env \
    -v ikev2-vpn-data:/etc/ipsec.d \
    -v /lib/modules:/lib/modules:ro \
    -p 500:500/udp \
    -p 4500:4500/udp \
    -d --privileged \
    hwdsl2/ipsec-vpn-server
```
#  配置文件
``` 
/root/vpn.env
```
 内容：
```
VPN_IPSEC_PSK=xxxxxxxxxx
VPN_USER=vpnuser
VPN_PASSWORD=xxxxxxxxxxxxxxxxx
VPN_L2TP_NET=192.168.46.0/24
VPN_L2TP_LOCAL=192.168.46.1
VPN_L2TP_POOL=192.168.46.10-192.168.46.254
```

#第二次启动
```
 docker start ipsec-vpn-server
```

## install l2tp ipsec 

## https://github.com/hwdsl2/setup-ipsec-vpn
首先，在你的 Linux 服务器\* 上全新安装以下系统之一。

使用以下命令快速搭建 IPsec VPN 服务器：

<details open>
<summary>
Ubuntu & Debian
</summary>

```bash
wget https://git.io/vpnsetup -O vpn.sh && sudo sh vpn.sh && sudo ikev2.sh --auto
```
</details>

<details>
<summary>
CentOS & RHEL
</summary>

```bash
wget https://git.io/vpnsetup-centos -O vpn.sh && sudo sh vpn.sh && sudo ikev2.sh --auto
```
</details>

<details>
<summary>
Amazon Linux 2
</summary>

```bash
wget https://git.io/vpnsetup-amzn -O vpn.sh && sudo sh vpn.sh && sudo ikev2.sh --auto
```
</details>

## install openvpn server on Linux
## https://github.com/Nyr/openvpn-install
```bash
wget https://git.io/vpn -O openvpn-install.sh && bash openvpn-install.sh
```

## install wireguard on Linux 
## https://github.com/Nyr/wireguard-install
```bash
wget https://git.io/wireguard -O wireguard-install.sh && bash wireguard-install.sh
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


## install ddns
https://github.com/newfuture/ddns

```
pip install ddns
```
docker 安装
```
```
docker run -d -v /path/to/config.json:/config.json --network host newfuture/ddns
```
