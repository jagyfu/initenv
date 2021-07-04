
## 绪论
dd前 使用fdisk -lu 注意查看下自己VPS的 磁盘路径 并不是所有VPS 都是 /dev/vda 这个路径 有些可能是 /dev/sda /dev/xvda
执行：fdisk -ul chr.img，可以查看chr.img信息 查找 start 值 使用开始值 * 512 算出柱面位置 默认扇区大小为512 挂载时注意修改这个值
注意自己的网卡名字，有些VPS并不是eth0 需要修改脚本内的网卡名字与其对应
如果缺少 wget 使用命令： yum install wget -y

此脚本只适应于CentOS 6.9 7.X 测试通过~

## 通用单网卡方案 (适应于绝大多数VPS)
```
wget https://download.mikrotik.com/routeros/6.47.8/chr-6.47.8.img.zip -O chr.img.zip && \
gunzip -c chr.img.zip > chr.img && \
mount -o loop,offset=512 chr.img /mnt && \
ADDR0=`ip addr show ens3 | grep global | cut -d’ ‘ -f 6 | head -n 1` && \
GATE0=`ip route list | grep default | cut -d’ ‘ -f 3` && \
mkdir -p /mnt/rw && \
echo “/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip route add gateway=$GATE0
” > /mnt/rw/autorun.scr && \
umount /mnt && \
echo u > /proc/sysrq-trigger && \
dd if=chr.img bs=1024 of=/dev/vda && reboot
```

 

## 阿里云经典双网卡 (注意分清 内外 网卡)

缺省网关
default via 202.5.30.254 dev eth0 proto static metric 100
10.0.0.0/8 dev eth1 proto kernel scope link src 10.0.122.21 metric 101 目标地址 <> 网关
202.5.30.0/24 dev eth0 proto kernel scope link src 202.5.30.231 metric 100 目标地址 <> 网关
```
wget https://download.mikrotik.com/routeros/6.47.4/chr-6.47.4.img.zip -O chr.img.zip
gunzip -c chr.img.zip > chr.img
mount -o loop,offset=512 chr.img /mnt
ADDR0=`ip addr show eth0 | grep global | cut -d’ ‘ -f 6 | head -n 1`
ADDR1=`ip addr show eth1 | grep global | cut -d’ ‘ -f 6 | head -n 1`
GATE0=`ip route list | grep default | cut -d’ ‘ -f 3`
GATE1=`ip route list | grep ‘10.0.0.0/8′ | cut -d’ ‘ -f 9`
GATE2=`ip route list | grep ‘202.5.30.0/24′ | cut -d’ ‘ -f 9`
mkdir -p /mnt/rw

echo “/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip address add address=$ADDR1 interface=[/interface ethernet find where name=ether2]
/ip route add gateway=$GATE0
/ip route add dst-address=10.0.0.0/8 gateway=$GATE1
” > /mnt/rw/autorun.scr

umount /mnt
echo u > /proc/sysrq-trigger
dd if=chr.img bs=1024 of=/dev/vda && reboot
```
 

另一款 双网卡的样本 (注意分清 内外 网卡)
196.10.68.0/24 dev eth0 proto kernel scope link src 196.10.68.24
169.254.0.0/16 dev eth0 scope link metric 1002
169.254.0.0/16 dev eth1 scope link metric 1003
10.0.0.0/8 dev eth1 proto kernel scope link src 10.0.87.152
default via 196.10.68.1 dev eth0
```
wget https://download.mikrotik.com/routeros/6.45.8/chr-6.45.8.img.zip -O chr.img.zip
gunzip -c chr.img.zip > chr.img
mount -o loop,offset=512 chr.img /mnt
ADDR0=`ip addr show eth0 | grep global | cut -d’ ‘ -f 6 | head -n 1`
ADDR1=`ip addr show eth1 | grep global | cut -d’ ‘ -f 6 | head -n 1`
GATE0=`ip route list | grep default | cut -d’ ‘ -f 3`
GATE1=`ip route list | grep ‘10.0.0.0/8′ | cut -d’ ‘ -f 9`
mkdir -p /mnt/rw

echo “/ip address add address=$ADDR0 interface=[/interface ethernet find where name=ether1]
/ip address add address=$ADDR1 interface=[/interface ethernet find where name=ether2]
/ip route add gateway=$GATE0
/ip route add dst-address=10.0.0.0/8 gateway=$GATE1
” > /mnt/rw/autorun.scr

umount /mnt
echo u > /proc/sysrq-trigger
dd if=chr.img bs=1024 of=/dev/vda && reboot
```
 

 

## 常见问题：
有些D完死活启不动连不上 是因为UEFI的缘故，跟脚本无关 请改用 ROS7.0Beta 版本 支持UEFI启动
wget https://download.mikrotik.com/routeros/7.0beta5/chr-7.0beta5.img.zip -O chr.img.zip

aws Cloud DD完以后 要手动关机，再开机即可连接了
```
echo 1 > /proc/sys/kernel/sysrq  
#向sysrq文件中写入1 开启SysRq功能
echo b > /proc/sysrq-trigger 
#强行立即重启系统
```
