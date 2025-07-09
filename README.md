# 🌐 Layer-Miner: Chromium CloudShell Automation

Layer-Miner adalah skrip otomatisasi yang memanfaatkan container [linuxserver/chromium](https://hub.docker.com/r/linuxserver/chromium) di lingkungan **Cloud Shell**, dirancang untuk menjalankan Chromium secara headless dengan konfigurasi optimal untuk aktivitas otomatis.

---

## 🔧 Fitur Utama

- 🚀 **Optimasi Jaringan Otomatis**  
  Mengaktifkan TCP BBR untuk performa jaringan maksimal.

- 🧰 **Instalasi Alat Pendukung**  
  Otomatis menginstal `rclone`, `htop`, `jq`, dan `screen`.

- 🧪 **Deteksi & Optimasi Resource**  
  Menyesuaikan konfigurasi berdasarkan kemampuan resource Cloud Shell secara real-time.

- 🧼 **Pembersihan Otomatis**  
  Menghapus file-file sementara dan log setelah setup selesai.

- 📢 **Notifikasi Telegram**  
  Kirim pemberitahuan ketika Cloud Shell mulai atau berhenti bekerja.

---

## 📁 Struktur Direktori

├── cloudshell-mining-setup.sh # Skrip utama untuk setup otomatis

├── reporter.sh # Skrip pengirim notifikasi Telegram

├── chromium-stable.tar # Docker image Chromium

├── chromium-data.tar.gz # Data Chromium (opsional)


---

## ▶️ Cara Penggunaan

1. **Persiapan File**
   - Upload file berikut ke direktori Cloud Shell Anda:
     - `token.json` (untuk notifikasi Telegram)
     - `chromium-stable.tar`
     - `chromium-data.tar.gz` (jika ingin memuat data sebelumnya)

2. **Eksekusi Skrip**
   Jalankan perintah berikut di Cloud Shell terminal:


   ```bash
   screen -S reporter
   chmod +x cloudshell-mining-setup.sh
   ./cloudshell-mining-setup.sh

   chmod +x reporter.sh
   ./reporter.sh

🛠️ Berdasarkan Proyek Open Source
Proyek ini menggunakan image dari:

linuxserver/chromium
Container Chromium berbasis LinuxServer.io untuk penggunaan ringan dan stabil di lingkungan headless.

⚠️ Disclaimer
Skrip ini hanya untuk tujuan pembelajaran dan eksperimen pribadi. Penggunaan pada layanan Cloud harus mematuhi Ketentuan Layanan Cloud. Penyalahgunaan dapat menyebabkan penangguhan akun.
