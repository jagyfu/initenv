#!/bin/sh

mkdir -p /root/soft/
cd /root/soft
if [ ! -e "udp2raw_x86" ]; then
## install udp2raw
  wget https://github.com/wangyu-/udp2raw-tunnel/releases/download/20200818.0/udp2raw_binaries.tar.gz -O udp2raw_binaries.tar.gz
  tar zxvf udp2raw_binaries.tar.gz
  mv udp2raw_x86 udp2raw
  chmod +x udp2raw_x86
fi

## install gost
if [ ! -e "gost" ]; then
  wget https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-386-2.11.1.gz -O gost-linux-386-2.11.1.gz
  gunzip -d gost-linux-386-2.11.1.gz
  mv gost-linux-386-2.11.1 gost
  chmod +x gost 
fi 

## install kcp
if [ ! -e "server_linux_amd64" ]; then
  wget https://github.com/xtaci/kcptun/releases/download/v20210103/kcptun-linux-386-20210103.tar.gz -O kcptun-linux-386-20210103.tar.gz
  tar xzvf kcptun-linux-386-20210103.tar.gz
  chmod +x server_linux_amd64
fi

## start kcp 
ps auxx | grep server_linux | grep -v grep | awk -F' ' '{print $2}' | xargs kill -9
./server_linux_amd64 -l :39733 -t 127.0.0.1:5400 -key mpassPLL --crypt tea -mtu 1200 -sndwnd 2048 -rcvwnd 2048 -mode fast2 -log kcptun2.log > kcptun2.log 2>&1 &

## start gost
ps auxx | grep gost | grep -v grep | awk -F' ' '{print $2}' | xargs kill -9
./gost -L=ss://chacha20-ietf:1234567p@:5400

## start udp2raw 
ps auxx | grep udp2raw_amd64| grep -v grep | awk -F' ' '{print $2}' | xargs kill -
./udp2raw_amd64 -s -l 0.0.0.0:19600 -r 127.0.0.1:39733 -k "okok"  --raw-mode faketcp -a > /root/udp2.log &
