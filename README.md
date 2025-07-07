# layer-miner

Skrip ini dirancang untuk menjalankan container Chromium (mis. untuk aktivitas otomatis) di lingkungan Cloud Shell, dengan konfigurasi optimasi jaringan, instalasi tool, setup `rclone`, dan pengambilan file dari Google Drive.

## 🔧 Fitur
- TCP BBR tuning otomatis
- Instalasi `rclone`, `htop`, `jq`
- Load dan jalankan container Chromium
- Bersih-bersih otomatis setelah setup

## 📁 Struktur Direktori


├── cloudshell-mining-setup.sh # Skrip utama


├── chromium-stable.tar # Image Docker Chromium


├── chromium-data.tar.gz # Data Chromium


## ▶️ Cara Menjalankan

1. Upload file `token.json`, `chromium-stable.tar`, dan `chromium-data.tar.gz` ke Cloud Shell.
2. Jalankan:

```bash
chmod +x cloudshell-mining-setup.sh
./cloudshell-mining-setup.sh
