
yum update -y
yum install socat -y

rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-4.el7.elrepo.noarch.rpm
yum --enablerepo=elrepo-kernel install kernel-ml
grub2-set-default 0

wget https://raw.githubusercontent.com/apernet/hysteria/master/install_server.sh
chmod +x install_server.sh
./install_server.sh



curl https://get.acme.sh | sh
ln -s /root/.acme.sh/acme.sh /usr/local/bin/acme.sh
acme.sh --set-default-ca --server letsencrypt



#acme.sh --issue -d us.vps.yfyfj.net --keylength ec-256 --standalone --insecure
#acme.sh --install-cert -d us.vps.yfyfj.net --ecc \
#        --key-file       /etc/hysteria/us.vps.yfyfj.net.key  \
#        --fullchain-file /etc/hysteria/us.vps.yfyfj.net.pem



cat > /etc/hysteria/config.json <<EOF
{
  "listen": ":60100",
  "acme": {
    "domains": [
      "us.vps.yfyfj.net"
    ],
    "email": "us.vps.yfyfj.net"
  },
  "obfs": "9Z8ZuA2Zpqhuk8yakXvMjDqEXBwY"
}
EOF
iptables -I INPUT -p tcp --dport 80 -j ACCEPT
iptables -I INPUT -p tcp --dport 443 -j ACCEPT
iptables -I INPUT -p udp --dport 60100 -j ACCEPT




cat > /etc/systemd/system/hysteria.service <<EOF
[Unit]
Description=Hysteria Server Service (config.json)
After=network.target
[Service]
Type=simple
ExecStart=/usr/local/bin/hysteria -config /etc/hysteria/config.json server
WorkingDirectory=/etc/hysteria
User=hysteria
Group=hysteria
Environment=HYSTERIA_LOG_LEVEL=info
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW
NoNewPrivileges=true
[Install]
WantedBy=multi-user.target
EOF



chown -R hysteria:hysteria /etc/hysteria/
systemctl daemon-reload
systemctl enable hysteria
systemctl start hysteria
#查看当前状态
systemctl status hysteria
#使用更改的配置文件重新加载 hysteria
systemctl reload hysteria
