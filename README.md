## 概要
本リポジトリは、Ruby on Rails を用いて開発した Twitter クローンアプリです。
ユーザー認証、ツイート投稿、ダイレクトメッセージ、通知機能など、
SNS に必要な主要機能を実装し、設計から開発まで行いました。

## 使用技術
- Ruby 3.2.1
- Rails 7.0.0
- PostgreSQL 14
- Bootstrap
- 開発環境：Docker
- 本番環境：Heroku
- 画像保存：Amazon S3

## 機能一覧
- サインアップ・ログイン(devise, github認証)
- プロフィール閲覧・編集
- ツイート機能(テキスト&画像)
- いいね
- リツイート
- フォロー
- コメント
- ブックマーク
- メッセージ機能(DM)
- 通知機能

## ER図(作成中)
```mermaid
---
title: "TwitterクローンER図"
---
erDiagram
    users ||--o{ tweets : ""
    users ||--o{ relationships : "following"
    users ||--o{ relationships : "follower"
    users ||--o{ comments : ""
    tweets ||--o{ comments : ""
    users ||--o{ retweets : ""
    tweets ||--o{ retweets : ""
    users ||--o{ likes : ""
    tweets ||--o{ likes : ""
    users ||--o{ notifications : "visitor"
    users ||--o{ notifications : "visited"
    users ||--o{ entries : ""
    rooms ||--o{ entries : ""
    users ||--o{ messages : ""
    rooms ||--o{ messages : ""

    users {
        bigint id PK
        string email
        string encrypted_password
        string name
        string phone_number
        date birth_date
        text self_introduction
        string place
        text website
        timestamp created_at
        timestamp updated_at
    }

    tweets {
        bigint id PK
        bigint user_id FK
        text content
        timestamp created_at
        timestamp updated_at
    }

    relationships {
        bigint id PK
        bigint following_id FK
        bigint follower_id FK
        timestamp created_at
        timestamp updated_at
    }

    comments {
        bigint id PK
        bigint user_id FK
        bigint tweet_id FK
        text content
        timestamp created_at
        timestamp updated_at
    }

    retweets {
        bigint id PK
        bigint user_id FK
        bigint tweet_id FK
        timestamp created_at
        timestamp updated_at
    }

    likes {
        bigint id PK
        bigint user_id FK
        bigint tweet_id FK
        timestamp created_at
        timestamp updated_at
    }

    notifications {
        bigint id PK
        bigint visitor_id FK
        bigint visited_id FK
        bigint tweet_id FK
        bigint comment_id FK
        string action
        boolean checked
        timestamp created_at
        timestamp updated_at
    }

    rooms {
        bigint id PK
        timestamp created_at
        timestamp updated_at
    }

    entries {
        bigint id PK
        bigint user_id FK
        bigint room_id FK
        timestamp created_at
        timestamp updated_at
    }

    messages {
        bigint id PK
        bigint user_id FK
        bigint room_id FK
        text content
        timestamp created_at
        timestamp updated_at
    }

```

## 画面イメージ
![twitter](https://github.com/user-attachments/assets/7f2bd04b-b9fd-46e2-a83e-54793c279ce2)
