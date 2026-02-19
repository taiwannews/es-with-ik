# 第一階段：下載器 (加入憑證更新)
FROM alpine:latest AS downloader

# 安裝 curl 與 ca-certificates 以確保 HTTPS 正常
RUN apk add --no-cache curl ca-certificates

# 下載 IK 插件
# -f: 若伺服器錯誤則報錯
# -L: 強制追蹤轉址 (處理 GitHub 到 S3 的關鍵)
# -H: 加入 User-Agent 避免被 GitHub 視為機器人攔截
RUN curl -fL -H "User-Agent: Mozilla/5.0" \
    https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v8.12.0/elasticsearch-analysis-ik-8.12.0.zip \
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