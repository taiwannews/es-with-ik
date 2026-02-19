# 第一階段：專門用來下載的環境 (使用輕量的 alpine)
FROM alpine:latest AS downloader
RUN apk add --no-cache wget
# 下載 IK 插件
RUN wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v8.12.0/elasticsearch-analysis-ik-8.12.0.zip -O /tmp/ik.zip

# 第二階段：最終的 Elasticsearch 鏡像
FROM elasticsearch:8.12.0

# 切換到 root 以安裝插件
USER root

# 從下載器階段把 ZIP 檔複製過來
COPY --from=downloader /tmp/ik.zip /tmp/ik.zip

# 執行安裝，完成後刪除暫存檔
RUN bin/elasticsearch-plugin install --batch file:///tmp/ik.zip && \
    rm /tmp/ik.zip

# 恢復 elasticsearch 使用者身份
USER elasticsearch