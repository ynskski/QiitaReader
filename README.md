# Qiitaのクライアントアプリ

## 概要
SwiftUI，Combine，URLSessionで実装したQiitaのクライアントアプリ

## 機能
### Qiitaユーザーの認証・プロフィール表示
- `GET /api/v2/oauth/authorize`で`code`を取得
- `POST /api/v2/access_tokens`で`access_token`を取得
- `access_token`は[KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess)を用いてKeyChainに保存
- `access_token`をリクエストヘッダーに含めて`GET /api/v2/authenticated_user`で認証中ユーザーを取得
- 同様に`GET /api/v2/authenticated_user/items`で認証中ユーザーの記事を取得
<img src="https://user-images.githubusercontent.com/37182704/105633140-4d501300-5e9a-11eb-8b99-16aff8249729.gif" width="300">

### 新着記事の表示・検索
- `GET /api/v2/items`で記事一覧を新着順で取得して表示
- `query`パラメータで検索
- pagination
<img src="https://user-images.githubusercontent.com/37182704/105633357-686f5280-5e9b-11eb-994e-d528630cc9a5.gif" width="300">

## 参考
[Qiita API v2ドキュメント - Qiita:Developer](https://qiita.com/api/v2/docs)
