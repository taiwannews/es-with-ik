# 使用官方 8.12.0 版本作為基底
FROM elasticsearch:8.12.0

# 切換到 root 進行插件安裝（確保權限）
USER root

# 安裝 IK 中文分詞插件
# --batch 代表自動同意授權，不中斷建構過程
RUN ./bin/elasticsearch-plugin install --batch https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v8.12.0/elasticsearch-analysis-ik-8.12.0.zip

# 確保插件目錄的擁有者為 elasticsearch 使用者
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/plugins

# 切換回 elasticsearch 使用者執行服務
USER elasticsearch