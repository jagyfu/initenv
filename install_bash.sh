#!/bin/sh

mkdir -p /root/soft/
cd /root/soft
wget https://github.com/wangyu-/udp2raw-tunnel/releases/download/20200818.0/udp2raw_binaries.tar.gz -O udp2raw_binaries.tar.gz
tar zxvf udp2raw_binaries.tar.gz
mv udp2raw_x86 udp2raw

wget https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-386-2.11.1.gz -O gost-linux-386-2.11.1.gz
gunzip -d gost-linux-386-2.11.1.gz
mv gost-linux-386-2.11.1 gost

wget https://github.com/xtaci/kcptun/releases/download/v20210103/kcptun-linux-386-20210103.tar.gz -O kcptun-linux-386-20210103.tar.gz
tar xzvf kcptun-linux-386-20210103.tar.gz

