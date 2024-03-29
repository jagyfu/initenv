#!/bin/sh

## set timezone
timedatectl set-timezone Asia/Shanghai

mkdir -p /home/work/videos/
chmod 777 /home/work/videos/
mkdir -p /etc/supervisor/
mkdir -p /home/work/logs/
chmod 777 /home/work/logs/
mkdir -p ~/soft

## install git ...
yum install python python2 python3 net-tools vim git supervisor dstat htop -y

## install gost
if [ ! -e "gost" ]; then
    wget https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-386-2.11.1.gz -O gost-linux-386-2.11.1.gz
    gunzip -d gost-linux-386-2.11.1.gz
    mv gost-linux-386-2.11.1 gost
    chmod +x gost 
    mv gost /usr/sbin/
fi 

## install base soft

cd ~/soft
if [ ! -e "go1.14.12.linux-amd64.tar.gz" ]; then
    wget https://golang.org/dl/go1.14.12.linux-amd64.tar.gz
    tar zxf go1.14.12.linux-amd64.tar.gz
    cp -rf go/bin/go* /usr/bin/
    cp -rf go /usr/local/
fi

#curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
#chmod a+rx /usr/local/bin/youtube-dl
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

## install ffmpeg
#yum install epel-release -y
#yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm -y
#yum install ffmpeg ffmpeg-devel -y

## isntall google
if [ ! -e "google-chrome-stable_current_x86_64.rpm" ]; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    yum install google-chrome-stable_current_x86_64.rpm -y
fi
## install redis
yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum --enablerepo=remi install redis -y
yum install redis -y

## install ffmpeg
rpm --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum install ffmpeg ffmpeg-devel -y


## complie video
#cd ~/youtube_crawler/GinVideo
#go build main.go
#mv -f main GinVideo
#cd scripts
#go build main.go
#mv -f main GinVideoTask


## install node_export
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar zxvf node_exporter-1.2.2.linux-amd64.tar.gz
mv node_exporter-1.2.2.linux-amd64 /usr/local/node_exporter
nohup /usr/local/node_exporter/node_exporter --web.listen-address=":19100" &
iptables -I INPUT -p tcp --dport 19100 -j ACCEPT

## iptables
iptables -I INPUT -p tcp --dport 8001 -j ACCEPT
iptables -I INPUT -p tcp --dport 8002 -j ACCEPT
iptables -I INPUT -p tcp --dport 65055 -j ACCEPT
iptables -I INPUT -p tcp --dport 42001 -j ACCEPT
iptables -I INPUT -p udp -s 192.168.0.0/16 --dport 53 -j ACCEPT
iptables-save > /etc/sysconfig/iptables


yum install supervisor -y
## start supervisor
echo_supervisord_conf > /etc/supervisord.conf
echo '[include]' >> /etc/supervisord.conf
echo 'files = /etc/supervisor/*.ini' >> /etc/supervisord.conf
if [ -d  ~/youtube_crawler/GinVideo/scripts/ ]; then
    cd ~/youtube_crawler/GinVideo/scripts/
    cp -f ginvideo.ini /etc/supervisor/ginvideo.ini
fi 
#supervisord -c /etc/supervisord.conf
systemctl start supervisord
## start http proxy
nohup gost -L=qqiloveu:qqiloveyou@:8002 > /dev/null 2>&1 &


