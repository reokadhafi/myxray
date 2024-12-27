```
sudo apt update && sudo apt upgrade -y
```
```
sudo apt install -y curl wget vim jq certbot uuid
```
```
bash <(curl -L https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh)
```
```
sudo systemctl daemon-reload
sudo systemctl restart xray
sudo systemctl enable xray
```
- ganti subdomain.reonolimits.my.id menjadi nama domain punya kamu
```
sudo certbot certonly --standalone -d subdomain.reonolimits.my.id
```
```
cat >/root/domain <<EOF
subdomain.reonolimits.my.id
EOF
mkdir -p /etc/xray
cat >/etc/xray/domain <<EOF
subdomain.reonolimits.my.id
EOF
```
- ganti user=root
```
sudo nano /etc/systemd/system/xray.service
```
```
cat >/usr/local/etc/xray/config.json <<EOF
{
  "inbounds": [
    {
      "port": 80,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "14a995ab-1098-4d94-9984-334744714882",
            "alterId": 0
#vmess
### reoneva 2025-04-06
},{"id": "d05b0f4b-c6af-4f88-a80b-4c0166a380fb","email": "reoneva"
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/vmessws",
          "headers": {
            "Host": "neva.reonolimits.my.id"
          }
        }
      }
    },
    {
      "port": 443,
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "14a995ab-1098-4d94-9984-334744714882",
            "email": "reo1"
#trojangrpc
### reoneva 2025-04-06
},{"password": "d05b0f4b-c6af-4f88-a80b-4c0166a380fb","email": "reoneva"
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/letsencrypt/live/neva.reonolimits.my.id/fullchain.pem",
              "keyFile": "/etc/letsencrypt/live/neva.reonolimits.my.id/privkey.pem"
            }
          ]
        },
        "grpcSettings": {
          "serviceName": "trojangrpc"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ],
  "dns": {
    "servers": [
      "8.8.8.8",
      "8.8.4.4"
    ]
  }
}
EOF
```
- Edit file .bashrc atau .bash_profile:
```
sudo nano ~/.bashrc
```
- Tambahkan /root ke dalam PATH:
```
export PATH=$PATH:/root
```
```
source ~/.bashrc
```
- Pasang Xmenu
```
wget -O updatedll "https://raw.githubusercontent.com/reokadhafi/myxray/main/updatedll"
```
```
chmod +x updatedll
```
- Ganti zona waktu
```
sudo timedatectl set-timezone Asia/Jakarta
```
- Menambah auto reboot vps (jam 7 pagi WIB)
```
sudo crontab -e
```
```
0 7 * * * /sbin/reboot
```
- Menambah auto delete akun expired setelah reboot
```
sudo crontab -e
```
```
@reboot /root/auto_delete_expired
```
- Menggunakan installer
```
wget https://raw.githubusercontent.com/reokadhafi/myxray/main/install.sh -O install.sh
```
```
chmod +x install.sh
```
```
./install.sh
```


