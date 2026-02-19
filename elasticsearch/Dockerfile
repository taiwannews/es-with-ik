# 第一階段：下載器
FROM alpine:latest AS downloader

# 安裝必要的工具
RUN apk add --no-cache curl ca-certificates

# 下載 IK 插件 (注意：網址已更新為 infinilabs)
# 8.12.0 確實在這裡：https://github.com/infinilabs/analysis-ik/releases
RUN curl -fL -H "User-Agent: Mozilla/5.0" \
    https://github.com/infinilabs/analysis-ik/releases/download/v8.12.0/elasticsearch-analysis-ik-8.12.0.zip \
    -o /tmp/ik.zip

# 第二階段：最終的 Elasticsearch 鏡像
FROM elasticsearch:8.12.0

USER root

# 從下載器階段把檔案複製過來
COPY --from=downloader /tmp/ik.zip /tmp/ik.zip

# 執行安裝，完成後刪除暫存檔
RUN bin/elasticsearch-plugin install --batch file:///tmp/ik.zip && \
    rm /tmp/ik.zip

# 恢復為 elasticsearch 使用者
USER elasticsearch