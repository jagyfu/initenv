## 安装prometheus


## ubuntu install grafana
#sudo apt-get install -y adduser libfontconfig1
#wget https://dl.grafana.com/enterprise/release/grafana-enterprise_8.1.4_amd64.deb
#sudo dpkg -i grafana-enterprise_8.1.4_amd64.deb

## centos install grafana
#wget https://dl.grafana.com/enterprise/release/grafana-enterprise-8.1.4-1.x86_64.rpm
#sudo yum install grafana-enterprise-8.1.4-1.x86_64.rpm

##run grafana 
#systemctl start grafana-server.service 

## import grafana json https://grafana.com/grafana/dashboards/8919


## install node export
wget https://github.com/prometheus/node_exporter/releases/download/v1.2.2/node_exporter-1.2.2.linux-amd64.tar.gz
tar zxvf node_exporter-1.2.2.linux-amd64.tar.gz
cd node_exporter-1.2.2.linux-amd64
cp node_exporter /usr/local/
## start node_exporter
nohup /usr/local/node_exporter/node_exporter --web.listen-address=":19100" &

