#!/bin/bash

echo "🔧 Menyetel parameter sistem..."
sudo sysctl vm.vfs_cache_pressure=50
echo "vm.vfs_cache_pressure=50" | sudo tee -a /etc/sysctl.conf
echo "net.core.default_qdisc=fq" | sudo tee -a /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "🔍 Verifikasi BBR..."
lsmod | grep bbr
sysctl net.ipv4.tcp_congestion_control
echo 3 | sudo tee /proc/sys/net/ipv4/tcp_fastopen

echo "📦 Install tools pendukung (htop, jq)..."
sudo apt update
sudo apt install htop jq -y

echo "⬇️ Install rclone..."
curl https://rclone.org/install.sh | sudo bash

# ========================
# Bagian: RCLONE CONF
# ========================
REMOTE_NAME="gdrive"
TOKEN_FILE="./token.json"
RCLONE_CONF_PATH="$HOME/.config/rclone/rclone.conf"
DEST_FOLDER="$(pwd)"
GDRIVE_FOLDER="Project-Tutorial/layer-miner"

if [ ! -f "$TOKEN_FILE" ]; then
  echo "❌ File token.json tidak ditemukan di path: $TOKEN_FILE"
  exit 1
fi

echo "⚙️ Menyiapkan rclone.conf..."
mkdir -p "$(dirname "$RCLONE_CONF_PATH")"
TOKEN=$(jq -c . "$TOKEN_FILE")

cat > "$RCLONE_CONF_PATH" <<EOF
[$REMOTE_NAME]
type = drive
scope = drive
token = $TOKEN
EOF

echo "✅ rclone.conf berhasil dibuat."

echo "📁 Menyalin file layer-miner dari Drive ke $DEST_FOLDER ..."
rclone copy --config="$RCLONE_CONF_PATH" "$REMOTE_NAME:$GDRIVE_FOLDER" "$DEST_FOLDER" --progress

# ========================
# Bagian: DOCKER & CHROMIUM
# ========================
echo "🐳 Menyiapkan kontainer Chromium..."

docker load -i chromium-stable.tar
sudo tar -xzvf chromium-data.tar.gz -C ~/

docker run -d \
  --name chromium-node \
  -v ~/chromium-data:/config \
  -p 3040:3040 \
  chromium-stable:latest

echo "🧹 Membersihkan file yang tidak dibutuhkan..."
sudo rm -f chromium-stable.tar
sudo rm -f chromium-data-ori.tar.gz
sudo rm -f chromium-data.tar.gz
sudo rm -f chromium-data-ori2.tar.gz
sudo rm -f chromium-data-single.tar.gz


echo "Kirim IP Cloud Shell ke VPS..."

CLOUD_ID=$(echo "$HOME" | awk -F'/' '{print $3}')  # hasil: username-cloud-shell
CLOUD_IP=$(curl -s ifconfig.me)
VPS_RECEIVER="http://103.63.25.150:5050"

curl -s "$VPS_RECEIVER?id=$CLOUD_ID&ip=$CLOUD_IP"

echo "✅ Selesai setup.mulai penambangan..."
ping 8.8.8.8
