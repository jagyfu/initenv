#!/bin/sh


yum install vim wget git dstat -y

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
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

systemctl status docker
systemctl enable docker
#启动docker
systemctl start docker
#安装docker-compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose


mkdir ros
cd ros

command='
version: "3"

services:

  routeros-7.9:
    image: yfyfj/ros:7.14
    restart: unless-stopped
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    ports:
      - "2222:22"
      - "2223:23"
      - "2280:80"
      - "8728:8728"
      - "8729:8729"
      - "8291:8291"
      - "1701:1701/udp"
      - "500:500/udp"
      - "4500:4500/udp"
      - "1194:1194"
      - "51194:51194"
      - "1194:1194/udp"
'
file="docker-compose.yml"
echo "$command" > "$file"


docker-compose up -d



## install realm
cd ~
mkdir realm
cd realm
wget https://github.com/zhboner/realm/releases/download/v2.6.3/realm-x86_64-unknown-linux-musl.tar.gz
tar zxvf realm-x86_64-unknown-linux-musl.tar.gz
mv realm /usr/sbin/
rm realm-x86_64-unknown-linux-musl.tar.gz

realmconfig='
[log]
level = "info"
output = "/var/log/realm.log"

[network]
no_tcp = false
use_udp = true


[[endpoints]]
listen = "0.0.0.0:64055"
remote = "127.0.0.1:65055"
listen_transport = "ws;host=www.baidu.com;path=/;tls;servername=www.baidu.com"


[[endpoints]]
listen = "0.0.0.0:41194"
remote = "127.0.0.1:51194"
listen_transport = "ws;host=www.baidu.com;path=/;tls;servername=www.baidu.com"

'
realmfile="config.toml"
echo "$realmconfig" > "$realmfile"
realm -c "$realmfile" -d
cd ~

## install gost
wget https://github.com/ginuerzh/gost/releases/download/v2.12.0/gost_2.12.0_linux_386.tar.gz
tar zxvf gost_2.12.0_linux_386.tar.gz
mv gost /usr/sbin/gost
chmod +x /usr/sbin/gost
nohup /usr/sbin/gost -L ss://chacha20-ietf:youtube090@:65055 -L ssu://chacha20-ietf:youtube090@:65055 > /dev/null 2>&1 &
