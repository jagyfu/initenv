#!/bin/sh
mkdir -p ./pbr
cd ./pbr

#电信
wget --no-check-certificate -c -O ct.txt https://ispip.clang.cn/chinatelecom_cidr.txt
#联通
wget --no-check-certificate -c -O cnc.txt https://ispip.clang.cn/unicom_cnc_cidr.txt
#移动
wget --no-check-certificate -c -O cmcc.txt https://ispip.clang.cn/cmcc_cidr.txt
#铁通
wget --no-check-certificate -c -O crtc.txt https://ispip.clang.cn/crtc_cidr.txt
#教育网
wget --no-check-certificate -c -O cernet.txt https://ispip.clang.cn/cernet_cidr.txt
#长城宽带/鹏博士
wget --no-check-certificate -c -O gwbn.txt https://ispip.clang.cn/gwbn_cidr.txt
#其他
wget --no-check-certificate -c -O other.txt https://ispip.clang.cn/othernet_cidr.txt
# netflix ip
wget --no-check-certificate -c -O netflix.txt https://cdn.jsdelivr.net/gh/QiuSimons/Netflix_IP@master/getflix.txt

{
echo "/ip route rule"
for net in $(cat ct.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat cnc.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat cmcc.txt) ; do
  echo "add dst-address=$net action=lookup table=CMCC"
done

for net in $(cat crtc.txt) ; do
  echo "add dst-address=$net action=lookup table=CMCC"
done

for net in $(cat cernet.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat gwbn.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done

for net in $(cat other.txt) ; do
  echo "add dst-address=$net action=lookup table=CT"
done
} > ../ros-route-CT-CMCC.rsc 

{
echo "/ip route rule"
for net in $(cat netflix.txt) ; do
  echo "add dst-address=$net action=lookup table=Netflix"
done
} > ../ros-route-Netflix.rsc


{
echo "/ip firewall address-list"
for net in $(cat netflix.txt) ; do
  echo "add list=Netflix address=$net"
done
} > ../ros-address-Netflix.rsc
{
echo "/ip firewall address-list"

for net in $(cat ct.txt) ; do
  echo "add list=my-CT address=$net"
done

for net in $(cat cnc.txt) ; do
  echo "add list=my-CT address=$net"
done

for net in $(cat cmcc.txt) ; do
  echo "add list=my-CMCC address=$net"
done

for net in $(cat crtc.txt) ; do
  echo "add list=my-CMCC address=$net"
done

for net in $(cat cernet.txt) ; do
  echo "add list=my-CT address=$net"
done

for net in $(cat gwbn.txt) ; do
  echo "add list=my-CT address=$net"
done

for net in $(cat other.txt) ; do
  echo "add list=my-CT address=$net"
done
} > ../ros-address-CT-CMCC.rsc 

cd ..
rm -rf ./pbr
