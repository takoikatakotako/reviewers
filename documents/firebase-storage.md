# Firebase Storage

Firebase Storage についてのドキュメントです。


## アクセスについて



https://storage.googleapis.com/reviewers-develop.appspot.com/guideline/teams.html
https://storage.googleapis.com/reviewers-production.firebasestorage.app/guideline/teams.html
gs://reviewers-production.firebasestorage.app




## Firebase Storage ルール

```
rules_version = '2';

service firebase.storage {
  match /b/{bucket}/o {

    // /image/user/{userId}/
    match /image/user/{userId}/{allPaths=**} {
      // 認証済みのすべてのユーザーはアクセス可能
      allow read: if request.auth != null;

      // 自分自身のディレクトリのみ書き込み可能、画像サイズは 2MB以下であること
      allow write: if request.auth != null
      && userId == request.auth.uid
      && request.resource.size < 2 * 1024 * 1024; 
    }
    
    // /guideline/
    match /guideline/{allPaths=**} {
      // 全ての読み取りが可能
      allow read: if true;
    }
  }
}
```


## /image/user/{userId}/

投稿用の画像が格納されるディレクトリです。


## /guideline/

利用規約、プライバシーポリシーなどが格納されたディレクトリです。


