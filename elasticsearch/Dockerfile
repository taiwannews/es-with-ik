# 使用官方 Elasticsearch 鏡像
FROM elasticsearch:8.12.0

USER root

# 使用 infinilabs 官方推薦的方式安裝 IK 插件
# 參考：https://github.com/infinilabs/analysis-ik
# 舊的 GitHub Releases 已停止更新，改用 release.infinilabs.com
RUN bin/elasticsearch-plugin install --batch \
    https://release.infinilabs.com/analysis-ik/stable/elasticsearch-analysis-ik-8.12.0.zip

# 恢復為 elasticsearch 使用者
USER elasticsearch