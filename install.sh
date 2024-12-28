#!/bin/bash

# Meminta input domain dari pengguna
read -p "Masukkan domain Anda (misalnya: subdomain.reonolimits.my.id): " DOMAIN

# Verifikasi jika domain tidak kosong
if [[ -z "$DOMAIN" ]]; then
  echo "Domain tidak boleh kosong!"
  exit 1
fi

# Meminta input email dari pengguna
read -p "Masukkan email Anda (misalnya: reo@gmail.com): " EMAIL

# Verifikasi jika domain tidak kosong
if [[ -z "$EMAIL" ]]; then
  echo "Email tidak boleh kosong!"
  exit 1
fi

# Install dependencies
sudo apt update
sudo apt install -y curl wget vim jq certbot uuid cron htop

# Install Xray
bash <(curl -L https://raw.githubusercontent.com/XTLS/Xray-install/main/install-release.sh)

# Menghasilkan sertifikat SSL menggunakan Certbot
#sudo certbot certonly --standalone -d $DOMAIN
sudo certbot certonly --standalone --email $EMAIL -d $DOMAIN

# Menyimpan domain di file /root/domain
echo "$DOMAIN" | sudo tee /root/domain

# Buat direktori untuk Xray jika belum ada
sudo mkdir -p /etc/xray
echo "$DOMAIN" | sudo tee /etc/xray/domain

# Edit file systemd xray.service
sudo sed -i 's/^User=.*$/User=root/' /etc/systemd/system/xray.service

# Mengonfigurasi Xray dengan file config.json
cat >/usr/local/etc/xray/config.json <<EOF
{
  "log": {
    "access": "/var/log/xray/access.log",
    "error": "/var/log/xray/error.log",
    "loglevel": "info"
  },
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
### reo1 2030-12-01
},{"id": "d05b0f4b-c6af-4f88-a80b-4c0166a380fb","email": "reo1"
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/vmessws",
          "headers": {
            "Host": "$DOMAIN"
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
            "email": "reo"
#trojangrpc
### reo1 2030-12-01
},{"password": "d05b0f4b-c6af-4f88-a80b-4c0166a380fb","email": "reo1"
          }
        ]
      },
      "streamSettings": {
        "network": "grpc",
        "security": "tls",
        "tlsSettings": {
          "certificates": [
            {
              "certificateFile": "/etc/letsencrypt/live/$DOMAIN/fullchain.pem",
              "keyFile": "/etc/letsencrypt/live/$DOMAIN/privkey.pem"
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

# tempat log debug
sudo chown -R root:root /var/log/xray/
sudo chmod -R 755 /var/log/xray/

# Reload dan restart Xray service
sudo systemctl daemon-reload
sudo systemctl restart xray
sudo systemctl enable xray

# Menambahkan /root ke dalam PATH
echo "export PATH=\$PATH:/root" | sudo tee -a ~/.bashrc
source ~/.bashrc

# Pasang Xmenu
wget -O updatedll "https://raw.githubusercontent.com/reokadhafi/myxray/main/updatedll"
chmod +x updatedll
./updatedll

# Ganti zona waktu
sudo timedatectl set-timezone Asia/Jakarta

# Hapus Installer
rm install.sh updatedll

# Selesai
echo "Instalasi selesai!"
