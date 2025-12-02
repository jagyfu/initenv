#!/bin/sh
## 透明代理分流

FOREIGN_SERVER_IP="1.2.3.0" 
REDSOCKS_PORT="54321"

# --- 清理旧规则 (如果存在) ---
sudo iptables -t nat -F REDSOCKS 2>/dev/null
sudo iptables -t nat -X REDSOCKS 2>/dev/null
sudo iptables -t nat -D OUTPUT -p tcp -j REDSOCKS 2>/dev/null
# 清理之前可能设置的 UDP 转发链 (避免冲突)
sudo iptables -t nat -F REDSOCKS_UDP 2>/dev/null
sudo iptables -t nat -X REDSOCKS_UDP 2>/dev/null
sudo iptables -t nat -D OUTPUT -p udp -j REDSOCKS_UDP 2>/dev/null
sudo iptables -t nat -D OUTPUT -p udp -j REDIRECT --to-ports 12346 2>/dev/null


# --- TCP 转发规则 ---
# 1. 创建 REDSOCKS 转发链
sudo iptables -t nat -N REDSOCKS

# 2. 排除国内 IP：如果目标在 china ipset 集合中，跳出链 (即直连)
sudo iptables -t nat -A REDSOCKS -m set --match-set china dst -j RETURN

# 3. 排除 Shadowsocks 服务器 IP：代理流量本身必须直连
sudo iptables -t nat -A REDSOCKS -d $FOREIGN_SERVER_IP -j RETURN

# 4. 将所有剩余 TCP 流量重定向到 RedSocks 监听的端口 (12345)
sudo iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-ports $REDSOCKS_PORT

# 5. 应用到 OUTPUT 链
# 排除 SSH 端口 (22)，防止失联
#sudo iptables -t nat -A OUTPUT -p tcp --dport 22 -j RETURN 

# 排除 RedSocks 本地流量
sudo iptables -t nat -A OUTPUT -p tcp -d 127.0.0.1 --dport $REDSOCKS_PORT -j RETURN
# 将所有剩余的本地发出的 TCP 流量导入 REDSOCKS 链
sudo iptables -t nat -A OUTPUT -p tcp -j REDSOCKS



# --- 3. 持久化规则 (Rocky Linux) ---
echo "--- 3. 正在保存 iptables 规则和 ipset 集合 ---"
# 保存 iptables 规则
#sudo service iptables save
# 保存 ipset 集合 (需要确保 ipset-service 在启动时会加载)
#sudo ipset save > /etc/ipset.conf
