```
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

//安装php以及扩展
yum install php71w php71w-fpm php71w-cli php71w-common php71w-devel php71w-gd php71w-pdo php71w-mysql php71w-mbstring php71w-bcmath -y

//开启服务
service php-fpm start
```

//修改/etc/nginx/nginx.conf 使其支持php 见下
//重启nginx
```
service nginx restart
```
---------------------配置

 

```
server {
 charset utf-8;
 client_max_body_size 128M;

 listen 80; ## listen for ipv4

 server_name localhost;
 root /var/www/;
 index index.php;

 location / {
  if (!-e $request_filename){
   rewrite ^/(.*)$ /index.php/$1 last;
  }
  try_files $uri $uri/ /index.php?$args;
 }

 location ~ \.php$ {
  include fastcgi.conf;
  fastcgi_pass 127.0.0.1:9000;
  try_files $uri =404;
 }
 location ~ \.php {
  fastcgi_pass 127.0.0.1:9000;
  fastcgi_index index.php;
  include /etc/fastcgi_params;
  fastcgi_split_path_info ^(.+\.php)(/?.*)$;
  fastcgi_param SCRIPT_FILENAME
  fastcgi_param PATH_INFO $fastcgi_path_info;
  fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
 }

 error_page 404 /404.html;
 location ~ /\.(ht|svn|git) {
  deny all;
 }
}
```
