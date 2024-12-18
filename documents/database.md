# Database

データベースについてのドキュメントです。
reviewers のデータベースには Firestore を利用しています。
Firestoreのルール については [Firestoreルール](firestore-rule.md) にまとめてあります。


## Relation

```mermaid
erDiagram
  merchandises ||--o{ reviews : "merchandisesは0以上のreviewを持つ"
  reviews ||--o{ review_reports : "reviewsは0以上のreportを持つ"
  user ||--o{ reviews : "userは0以上のreviewsを持つ"
  user ||--o{ contacts : "userは0以上のcontactsを持つ"

  reviews {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    string uid "投稿したユーザーID"
    boolean deleted "削除済み判定フラグ"
    string code "商品コード, スキャンしたバーコードの文字列"
    string(enum) codeType "コードタイプ, スキャンしたバーコードのタイプ。特定の値が入る。(EAN13, EAN8)"
    string comment "レビューコメント"
    list(string) images "添付した画像名の配列"
    int rate "レビューレート, 1-5の値が格納される"
    timestamp createdAt "ドキュメント生成時間"
    timestamp updatedAt "ドキュメント更新時間"
  }
  review_reports {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    string(enum) status "レポートのステータス、特定の値が入る"
    boolean uid "レポートしたユーザーのID"
    string reviewId "レポート対象のレビューのID"
    string message "補足などに用いられるメッセージ"
    timestamp createdAt "ドキュメント生成時間"
    timestamp updatedAt "ドキュメント更新時間"
  }
  merchandises {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    bool deleted "有効な商品か否か"
    string(enum) status "商品のステータス。特定の値が入る。(WaitingForReview, ReviewCompleted)"
    string name "商品名"
    string code "商品コード, スキャンしたバーコードの文字列"
    string codeType "スキャンしたバーコードのタイプ。特定の値が入る。(EAN13, EAN8)"
    string image "画像のファイル名。無い場合は空文字となる。"
    string imageRefarenceReviewId "画像の参照先のレビューのID。無い場合は空文字。"
    timestamp createdAt "ドキュメント生成時間"
    string createdUid "ドキュメントを生成したユーザーのUserID, 管理画面から作成する場合はADMINがはいる。"
    timestamp updatedAt "ドキュメント更新時間"
    string updatedUid "ドキュメントを更新したユーザーのUserID, 管理画面から更新する場合はADMINがはいる。"
  }
  contacts {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    string uid "お問い合わせしたユーザーのID"
    string(enum) status "お問い合わせのステータス、特定の値が入る"
    string email "お問い合わせ内容のメッセージ"
    string message "お問い合わせ内容メッセージ"
    string memo "補足などに用いられるメッセージ"
    timestamp createdAt "ドキュメント生成時間"
    timestamp updatedAt "ドキュメント更新時間"
  }
```


## reviews

商品レビューが格納されるコレクションです。

```mermaid
erDiagram
  reviews {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    string uid "投稿したユーザーID"
    boolean deleted "削除済み判定フラグ"
    string code "商品コード, スキャンしたバーコードの文字列"
    string(enum) codeType "コードタイプ, スキャンしたバーコードのタイプ。特定の値が入る。(EAN13, EAN8)"
    string comment "レビューコメント"
    list(string) images "添付した画像名の配列"
    int rate "レビューレート, 1-5の値が格納される"
    timestamp createdAt "ドキュメント生成時間"
    timestamp updatedAt "ドキュメント更新時間"
  }
```

codeType には以下のいずれかの値が入ります。
- EAN13
- EAN8


## merchandises

食品の情報が格納されるコレクションです。

```mermaid
erDiagram
  merchandises {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    string name "商品名"
    bool deleted "有効な商品か否か"
    string(enum) status "商品のステータス。特定の値が入る。(WaitingForReview, ReviewCompleted)"
    string code "商品コード, スキャンしたバーコードの文字列"
    string codeType "スキャンしたバーコードのタイプ。特定の値が入る。(EAN13, EAN8)"
    string image "画像のファイル名。無い場合は空文字となる。"
    string imageRefarenceReviewId "画像の参照先のレビューのID。無い場合は空文字。"
    timestamp createdAt "ドキュメント生成時間"
    string createdUid "ドキュメントを生成したユーザーのUserID, 管理画面から作成する場合はADMINがはいる。"
    timestamp updatedAt "ドキュメント更新時間"
    string updatedUid "ドキュメントを更新したユーザーのUserID, 管理画面から更新する場合はADMINがはいる。"
  }
```



## reports
報告が格納されるコレクション


```mermaid
erDiagram
  reports {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    string(enum) status "レポートのステータス、特定の値が入る"
    boolean uid "レポートしたユーザーのID"
    string reviewId "レポート対象のレビューのID"
    string message "補足などに用いられるメッセージ"
    timestamp createdAt "ドキュメント生成時間"
    timestamp updatedAt "ドキュメント更新時間"
}
```

## contacts

```mermaid
erDiagram
  contacts {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    string uid "お問い合わせしたユーザーのID"
    string(enum) status "お問い合わせのステータス、特定の値が入る"
    string email "お問い合わせ内容のメッセージ"
    string message "お問い合わせ内容メッセージ"
    string memo "補足などに用いられるメッセージ"
    timestamp createdAt "ドキュメント生成時間"
    timestamp updatedAt "ドキュメント更新時間"
  }
```

### uid: string
ドキュメントID, ドキュメント作成時に生成されたID

### status: string(enum)
`xxx`, `yyy` のいずれかの値を持つ
