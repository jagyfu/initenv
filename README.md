# initenv


nohup /root/gost -L=:33306/112.126.115.30:3306 > /dev/null 2>&1 &

nohup /root/gost -L=:42001/123.57.217.132:42001 > /dev/null 2>&1 &


## another
nohup /root/gost -L=:42001/10.0.34.218:42001 > /dev/null 2>&1 &
nohup /root/gost -L=:33006/10.0.34.218:33006 > /dev/null 2>&1 &


## check media unlock
bash <(curl -sSL "https://github.com/CoiaPrant/MediaUnlock_Test/raw/main/check.sh")

## ddros
bash <(curl -sSL "https://raw.githubusercontent.com/jagyfu/initenv/main/ddros.sh")
