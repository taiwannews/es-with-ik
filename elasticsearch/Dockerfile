# 使用官方 Elasticsearch 鏡像
FROM elasticsearch:8.12.0

USER root

# 使用 infinilabs 官方推薦的方式安裝 IK 插件
# 這裡使用 stable 網址，下載速度更快且更穩定
RUN bin/elasticsearch-plugin install --batch \
    https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-8.12.0.zip

# 將插件目錄的所有權還給 elasticsearch 使用者 (UID 1000)
RUN chown -R 1000:0 /usr/share/elasticsearch/plugins

# 加入自訂 entrypoint，防止平台強制以 root 執行
COPY docker-entrypoint-custom.sh /usr/local/bin/docker-entrypoint-custom.sh
RUN chmod +x /usr/local/bin/docker-entrypoint-custom.sh

# 設定 entrypoint：如果以 root 啟動，自動降權為 elasticsearch
ENTRYPOINT ["/usr/local/bin/docker-entrypoint-custom.sh"]
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]

# 預設以 elasticsearch 使用者執行（正常情況）
USER 1000