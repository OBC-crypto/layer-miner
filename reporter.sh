start_reporter() {
  CLOUD_ID=$(echo "$HOME" | awk -F'/' '{print $3}')
  VPS_RECEIVER="http://103.63.25.150:5051/report"

  while true; do
    CLOUD_IP=$(curl -s ifconfig.me)
    TIMESTAMP=$(date '+%Y-%m-%dT%H:%M:%S')  # Gunakan format aman URL
    REPORT_URL="${VPS_RECEIVER}?id=${CLOUD_ID}&ip=${CLOUD_IP}&ts=${TIMESTAMP}"

    echo "📤 Report IP: $CLOUD_ID ($CLOUD_IP) at $TIMESTAMP"
    echo "➡️ Request: $REPORT_URL"

    curl -s "$REPORT_URL" >> reporter.log 2>&1

    sleep 60
  done
}

# Panggil fungsi di background
start_reporter &
