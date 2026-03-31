#!/bin/bash
set -e

# 轉交給官方 entrypoint，並在 root 情境下自動降權
ES_ENTRYPOINT="/usr/local/bin/docker-entrypoint.sh"

# 如果以 root 身份執行，自動降權為 elasticsearch 使用者 (UID 1000)
if [ "$(id -u)" = "0" ]; then
  # 確保 elasticsearch 資料目錄擁有正確的權限
  chown -R 1000:0 /usr/share/elasticsearch/data 2>/dev/null || true
  chown -R 1000:0 /usr/share/elasticsearch/logs 2>/dev/null || true
  chown -R 1000:0 /usr/share/elasticsearch/plugins 2>/dev/null || true

  # 使用 runuser 降權執行官方 entrypoint
  exec runuser -u elasticsearch -- "$ES_ENTRYPOINT" "$@"
fi

# 如果已經不是 root，直接交給官方 entrypoint
exec "$ES_ENTRYPOINT" "$@"
