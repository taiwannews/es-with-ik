FROM elasticsearch:8.12.0

# 切換到 root 以安裝必要工具與插件
USER root

# 1. 安裝 curl (用於穩定下載)
# 2. 手動下載 IK 插件到 /tmp
# 3. 使用本地檔案進行安裝 (file://)
# 4. 刪除暫存檔並清理快取
RUN apt-get update && apt-get install -y curl && \
    curl -L -o /tmp/ik.zip https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v8.12.0/elasticsearch-analysis-ik-8.12.0.zip && \
    bin/elasticsearch-plugin install --batch file:///tmp/ik.zip && \
    rm /tmp/ik.zip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# 確保權限正確
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/plugins

# 切換回 elasticsearch 使用者
USER elasticsearch