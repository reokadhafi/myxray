```
sudo apt update && sudo apt upgrade -y
```
```
sudo apt install -y curl wget vim
```
```
bash <(curl -L https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh)
```
```
sudo systemctl daemon-reload
sudo systemctl restart xray
sudo systemctl enable xray
```
```
sudo apt install certbot
```
- ganti subdomain.reonolimits.my.id menjadi nama domain punya kamu
```
sudo certbot certonly --standalone -d subdomain.reonolimits.my.id
```
```
cat >/root/domain <<EOF
subdomain.reonolimits.my.id
EOF
```
```
mkdir -p /etc/xray
cat >/etc/xray/domain <<EOF
subdomain.reonolimits.my.id
EOF
```
```
sudo apt install jq -y
```
```
cat >/usr/local/etc/xray/config.json <<EOF
{
  "inbounds": [
    {
      "port": 80,  // Port untuk VMess WebSocket tanpa TLS
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "14a995ab-1098-4d94-9984-334744714882",  // UUID untuk VMess
            "alterId": 0
#vmess
          }
        ]
      },
      "streamSettings": {
        "network": "ws",  // Menggunakan WebSocket
        "wsSettings": {
          "path": "/vmessws",  // Path untuk VMess WS
          "headers": {
            "Host": "ovh.reonolimits.my.id"  // Host
          }
        }
      }
    },
    {
      "port": 443,  // Port untuk Trojan gRPC dengan TLS
      "protocol": "trojan",
      "settings": {
        "clients": [
          {
            "password": "14a995ab-1098-4d94-9984-334744714882",  // Password untuk Trojan
            "email": "reo1"
#trojangrpc
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",  // Menggunakan gRPC
        "security": "tls",  // Mengaktifkan TLS
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/letsencrypt/live/ovh.reonolimits.my.id/fullchain.pem",  // Sertifikat TLS dari Certbot
              "keyFile": "/etc/letsencrypt/live/ovh.reonolimits.my.id/privkey.pem"  // Private key dari Certbot
            }
          ]
        },
        "grpcSettings": {
          "serviceName": "trojangrpc"  // Nama service gRPC
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
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


