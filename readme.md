# TWN 新聞網站 DB 服務搬遷

1. 原本使用 mysql + 斷詞進行全文檢索，現在要改為 mariadb + els
2. 原本部署在 linode, 現在要搬遷到 zeabur 部署
3. 原本使用 docker-compose 現在改用 k3s 的 yaml 部署
4. 因為使用 zeabur 模板，因此需要使用 zeabur cli 將服務部署
   https://zeabur.com/docs/zh-TW/deploy/deploy-in-cli
