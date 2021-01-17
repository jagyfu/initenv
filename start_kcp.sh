#!/bin/sh


cd /root/kcptun/
#/root/gost/gost -L=ss://chacha20-ietf:qqwwqq@:5400 > gost.log &

ps auxx | grep server_linux | grep -v grep | awk -F' ' '{print $2}' | xargs kill -9
./server_linux_amd64 -l :38766 -t 127.0.0.1:5400 -key qqwwee --crypt blowfish -mtu 1200 -sndwnd 2048 -rcvwnd 2048 -mode fast -log kcptun.log > kcptun.log 2>&1 &

./server_linux_amd64 -l :39733 -t 127.0.0.1:5400 -key eiuwuw --crypt tea -mtu 1200 -sndwnd 2048 -rcvwnd 2048 -mode fast2 -log kcptun2.log > kcptun2.log 2>&1 &
echo "开始运行Kcptun"
