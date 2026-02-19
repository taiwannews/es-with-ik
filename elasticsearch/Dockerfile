# 使用官方 Elasticsearch 鏡像
FROM elasticsearch:8.12.0

USER root

# 使用 infinilabs 官方推薦的方式安裝 IK 插件
# 這裡使用 stable 網址，下載速度更快且更穩定
RUN bin/elasticsearch-plugin install --batch \
    https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-8.12.0.zip

# 【核心修復】
# 1. 將插件目錄的所有權還給 elasticsearch 使用者 (UID 1000)
# 2. 切換回 UID 1000 啟動，徹底解決 "can not run as root" 錯誤
RUN chown -R 1000:0 /usr/share/elasticsearch/plugins

USER 1000