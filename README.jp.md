# ivis_admin
[![ko](https://img.shields.io/badge/lang-ko-red.svg)](https://github.com/picel/IVIS_ADMIN/blob/main/README.md)
[![ja](https://img.shields.io/badge/lang-ja-blue.svg)](https://github.com/picel/IVIS_ADMIN/blob/main/README.jp.md)

## 概要
- IVIS Labの新入生の応募者を管理するための管理者パネル
- [IVIS Labの新入生の応募者を管理するための管理者パネル](https://ivis.dev) で登録した情報と応募書類を閲覧可能
- [IVIS INTERNAL NAS](https://github.com/picel/IVIS_NAS) で作成されたアカウントでログイン可能

## 使用技術
- Flutter
    - http
        - ユーザー認証サーバーと通信
        - バックエンドサーバーと通信
    - shared_preferences
        - ログイン情報(JWTトークン)保存
    - responsive_builder
        - レスポンシブデザイン
- Nginx
    - Let's Encrypt
        - SSL認証書発行 (.devドメイン用)
    - Reverse Proxy

## 実行画面
- ログイン画面<br>
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222893752-bd3cf393-fd54-4b0b-b7cd-09253a5d8528.png"><br>
>Mobile<p align="center"><img src="https://user-images.githubusercontent.com/30901178/222893823-3dfb510d-6fea-4b9a-8810-e0748ea6fa92.PNG" height="400">
</p>
- ダッシュボード
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222894388-ee29c150-24e2-4a58-8e61-ed789c1bbdae.png"><br>
>Mobile<p align="center"><img src="https://user-images.githubusercontent.com/30901178/222894399-4be1748b-1e95-43a0-bcc2-832cedd4b40c.PNG" height="400">
</p>
- 応募者一覧
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222894427-5e9d7733-c52f-4374-ad7e-dee4e352e87b.png"><br>
>Mobile<p align="center"><img src="https://user-images.githubusercontent.com/30901178/222894430-b8a52932-442d-450f-9601-3b20c50fc5c8.PNG" height="400">
</p>
- 応募書類閲覧
>Desktop
<img src="https://user-images.githubusercontent.com/30901178/222894450-ed4598f2-d023-46fe-a9fc-fc5b1fda2dc6.png"><br>
>Mobile<p align="center"><img src="https://user-images.githubusercontent.com/30901178/222894452-fbab1ae1-d271-4218-ae05-e52831562ba6.PNG" height="400">
</p>
## 更新履歴
- 2023.02.21.
    - 初期バージョン作成
- 2023.02.28.
    - サーバーとの通信
    - ログイン機能実装
    - 応募者一覧表示機能実装
    - 応募書類閲覧機能実装
- 2023.03.04.
    - モバイル環境でのレスポンシブデザイン実装
    - GitHubリポジトリ作成
    - README.md作成
    - ログイン画面での無限ルーティング問題解決