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
- Menambah auto reboot,auto delete exp,auto delete log(jam 7 pagi WIB)
```
sudo crontab -e
```
0 7 * * * /sbin/reboot
@reboot /root/auto_delete_expired
@reboot cat /dev/null > /var/log/xray/access.log && cat /dev/null > /var/log/xray/error.log
```
