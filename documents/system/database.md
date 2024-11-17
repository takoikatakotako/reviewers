# Database
データベースについてのドキュメントです。
レビュワーズのデータベースには Firestore を利用しています。


## reviews

レビューが格納されるコレクション

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


## merchandises

食品の情報が格納されるコレクション

```mermaid
erDiagram
  merchandises {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    bool enable "有効な商品か否か"
    boolean status "商品のステータス"
    string name "商品コード, スキャンしたバーコードの文字列"
    string(enum) code "コードタイプ, スキャンしたバーコードのタイプ。特定の値が入る。(EAN13, EAN8)"
    string codeType "レビューコメント"
    list(string) image "添付した画像名の配列"
    int rate "レビューレート, 1-5の値が格納される"
    timestamp createdAt "ドキュメント生成時間"
    string updatedUid "ドキュメントを更新したユーザーのUserID, 管理画面から更新する場合はADMINがはいる。"
    timestamp updatedAt "ドキュメント更新時間"
    string updatedUid "ドキュメントを更新したユーザーのUserID, 管理画面から更新する場合はADMINがはいる。"
}
```

```
        && 'enable' in merchandise && merchandise.enable is bool
        && 'status' in merchandise && merchandise.status is string
        && 'name' in merchandise && merchandise.name is string
        && 'code' in merchandise && merchandise.code is string
        && 'codeType' in merchandise && merchandise.codeType is string
        && 'image' in merchandise && merchandise.image is string
        && 'imageRefarenceReviewId' in merchandise && merchandise.imageRefarenceReviewId is string
        && 'createdAt' in merchandise && merchandise.createdAt is timestamp
        && 'createdUid' in merchandise && merchandise.createdUid is string
        && 'updatedAt' in merchandise && merchandise.updatedAt is timestamp
        && 'updatedUid' in merchandise && merchandise.updatedUid is string;
      }
```


### createdAt: timestamp
ドキュメント生成時間

### createdUid: String
作成したユーザーのID、管理者の場合は `ADMIN` が入る

### code: string
スキャンしたバーコードの文字列

### codeType: string
スキャンしたバーコードのタイプ。以下の値が入る。
- EAN13
- EAN8

### enable: boolean
有効かどうか

### image: string
画像のファイル名。無い場合は空文字となる。

### imageReferenceReviewId: string
画像の参照先のレビューのID。無い場合は空文字。

### name: string
商品名

### status: string
ステータス。以下の値が入る。
- WaitingForReview
- ReviewCompleted

### updatedAt: timestamp
更新時の時間

### updatedUid: String
更新したユーザーのID、管理者の場合は `ADMIN` が入る。



## reports
報告が格納されるコレクション


```mermaid
erDiagram
  reports {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    bool status "有効な商品か否か"
    boolean uid "商品のステータス"
    string reviewId "商品コード, スキャンしたバーコードの文字列"
    string message "レビューレート, 1-5の値が格納される"
    timestamp createdAt "ドキュメント生成時間"
    timestamp updatedAt "ドキュメント更新時間"
}
```


```
        && 'status' in report && report.status is string
        && 'uid' in report && report.uid is string
        && 'reviewId' in report && report.reviewId is string
        && 'message' in report && report.message is string
        && 'createdAt' in report && report.createdAt is timestamp
        && 'updatedAt' in report && report.updatedAt is timestamp;
```
