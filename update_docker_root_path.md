修改openwrt的docker root目录


1 创建目录
```
 mkdir /data/docker/
```

2 复制原有内容
```
cp -rf /opt/docker /data/
```

3 修改配置
```
vim /etc/config/dockerd

修改其中的root
config globals 'globals'
#	option alt_config_file "/etc/docker/daemon.json"
#	option data_root "/opt/docker/"
	option data_root "/data/docker/"
	option log_level "warn"
#	list registry_mirror "https://<my-docker-mirror-host>"
#	list registry_mirror "https://hub.docker.com"


```

4  启动
```
/etc/init.d/dockerd start
docker info
```
检查
