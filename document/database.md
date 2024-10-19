# Database
データベースについてのドキュメントです。
Reviewsのデータベースには Firestore を利用しています。


## reviews
レビューが格納されるコレクションです。

### id: string
ドキュメント作成時に生成されたid

### code: string
スキャンしたバーコードの文字列

### codeType: string
スキャンしたバーコードのタイプ。以下の値が入る。
- EAN13
- EAN8

### comment: string
レビューコメント。

### createdAt: timestamp
ドキュメント生成時間

### deleted: boolean
削除済み判定フラグ

### images: [string]
添付した画像名の配列

### rate: Int
レート。1-5の値が格納される

### uid: String
投稿したユーザーID

### updatedAt: timestamp
更新時の時間


## merchandises
食品の情報が格納されるコレクション

### id: string
ドキュメント作成時に生成されたid

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

### imageRefarenceReviewId: string
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
