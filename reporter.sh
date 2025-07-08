#!/bin/bash
CLOUD_ID=$(echo "$HOME" | awk -F'/' '{print $3}')
VPS_RECEIVER="http://103.139.192.168:80/report"

while true; do
  CLOUD_IP=$(curl -s ifconfig.me)
  TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  echo "📤 Report IP: $CLOUD_ID ($CLOUD_IP) at $TIMESTAMP"
  curl -s "$VPS_RECEIVER?id=$CLOUD_ID&ip=$CLOUD_IP&ts=$TIMESTAMP" > /dev/null
  sleep 60
done
