# Database
データベースについてのドキュメントです。
reviewers のデータベースには Firestore を利用しています。


## Relation

```mermaid
erDiagram
    merchandises ||--o{ reviews : "merchandisesは0以上のreviewを持つ"
    reviews ||--o{ reports : "reviewsは0以上のreportを持つ"
    user ||--o{ reviews : "userは0以上のreviewsを持つ"

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
    merchandises {
    string id PK "ドキュメントID, ドキュメント作成時に生成されたID"
    bool enable "有効な商品か否か"
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


## Firestoreルール

```
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
  
    ////////////////////////////////////////
    // reviews collection
    ////////////////////////////////////////
    match /reviews/{reviewId} {
      // read: 認証済みのすべてのユーザーが読み取り可能
      allow read: if request.auth != null;

			// create: 認証済み、バリデーション通過、uidが一致の場合作成可能
			allow create: if request.auth != null
      && isValidCreateReview(request.resource.data)
      && request.resource.data.uid == request.auth.uid;

			// update: 認証済み、uidが一致の場合更新可能
			allow update: if request.auth != null
      && resource.data.uid == request.auth.uid;

//       // ルールの記述
//       match /comments/{document=**} {
//         // ユーザー情報の取得のルール
//         allow read: if request.auth != null;

//         // ユーザー情報の作成のルール
//         allow write: if request.auth != null;
//       }
    }
    
    // createのバリデーション
    function isValidCreateReview(review) {
      return review.size() == 9
      && 'uid' in review && review.uid is string
      && 'deleted' in review && review.deleted is bool
      && 'code' in review && review.code is string
      && 'codeType' in review && review.codeType is string
      && 'comment' in review && review.comment is string
      && 'images' in review && review.images is list
      && 'rate' in review && review.rate is int
      && 'createdAt' in review && review.createdAt is timestamp
      && 'updatedAt' in review && review.updatedAt is timestamp;
    }


    ////////////////////////////////////////
    // profiles collection
    ////////////////////////////////////////
    match /profiles/{userId} {
      // read: 認証済みのすべてのユーザーが読み取り可能
      allow read: if request.auth != null;

			// create: 認証済み、バリデーション通過(TODO)、uidが一致の場合作成可能
			allow create: if request.auth != null
      && request.auth.uid == userId;

			// update: 認証済み、バリデーション通過、uidが一致の場合作成可能
			allow update: if request.auth != null
      && request.auth.uid == userId;
    }
    
    


    ////////////////////////////////////////
    // blocked_users collection
    ////////////////////////////////////////
    match /blocked_users/{blocked_user_id} {
      // read: 認証済みのすべてのユーザーが読み取り可能
      allow read: if request.auth != null;

			// create: 認証済み、バリデーション通過(TODO)
			allow create: if request.auth != null
      && request.auth.uid == request.resource.data.uid;
    }


    ////////////////////////////////////////
    // merchandise collection
    ////////////////////////////////////////
    match /merchandises/{merchandiseId} {
      // read: 認証済みのすべてのユーザーが読み取り可能
      allow read: if request.auth != null;

			// create: 認証済み、バリデーション通過(TODO)
			allow create: if request.auth != null
      && isValidCreateMerchandise(request.resource.data)
      && request.resource.data.createdUid == request.auth.uid
      && request.resource.data.updatedUid == request.auth.uid;
            
      // createのバリデーション
      function isValidCreateMerchandise(merchandise) {
        return merchandise.size() == 11
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
    }
    

    ////////////////////////////////////////
    // report collection
    ////////////////////////////////////////
    match /reports/{reportId} {
      // read: 認証済みのすべてのユーザーが読み取り可能
      allow read: if request.auth != null;

			// create: 認証済み、バリデーション通過(TODO)
			allow create: if request.auth != null
      && isValidCreateReport(request.resource.data)
      && request.resource.data.uid == request.auth.uid;
            
      // createのバリデーション
      function isValidCreateReport(report) {
        return report.size() == 6
        && 'status' in report && report.status is string
        && 'uid' in report && report.uid is string
        && 'reviewId' in report && report.reviewId is string
        && 'message' in report && report.message is string
        && 'createdAt' in report && report.createdAt is timestamp
        && 'updatedAt' in report && report.updatedAt is timestamp;
      }
    }    
  }
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
    bool enable "有効な商品か否か"
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
