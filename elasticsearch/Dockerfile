# 第一階段：下載器
FROM alpine:latest AS downloader

# 安裝 curl 而不是 wget，因為 curl 處理 GitHub 轉址更強
RUN apk add --no-cache curl

# 下載 IK 插件 (加入 User-Agent 避免被 GitHub 拒絕)
RUN curl -fL -H "User-Agent: Mozilla/5.0" \
    https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v8.12.0/elasticsearch-analysis-ik-8.12.0.zip \
    -o /tmp/ik.zip

# 第二階段：最終鏡像
FROM elasticsearch:8.12.0

USER root

# 從下載器階段複製
COPY --from=downloader /tmp/ik.zip /tmp/ik.zip

# 執行安裝
RUN bin/elasticsearch-plugin install --batch file:///tmp/ik.zip && \
    rm /tmp/ik.zip

USER elasticsearch