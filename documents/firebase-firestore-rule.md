# Firestore Rule

Firestore のルールについてです。

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
    // review_reports collection
    ////////////////////////////////////////
    match /review_reports/{reportId} {
      // read: 認証済みのすべてのユーザーが読み取り可能
      allow read: if request.auth != null;

			// create: 認証済み、バリデーション通過(TODO)
			allow create: if request.auth != null
      && isValidCreateReport(request.resource.data)
      && request.resource.data.uid == request.auth.uid;
            
      // createのバリデーション
      function isValidCreateReport(review_reports) {
        return review_reports.size() == 6
        && 'status' in review_reports && review_reports.status is string
        && 'uid' in review_reports && review_reports.uid is string
        && 'reviewId' in review_reports && review_reports.reviewId is string
        && 'message' in review_reports && review_reports.message is string
        && 'createdAt' in review_reports && review_reports.createdAt is timestamp
        && 'updatedAt' in review_reports && review_reports.updatedAt is timestamp;
      }
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
    // contacts collection
    ////////////////////////////////////////
    match /contacts/{contactId} {
      // read: すべてのユーザーが読み取り不可能、可能なのは管理者のみ
      allow read: if false;

			// create: 認証済み、バリデーション通過(TODO)
			allow create: if request.auth != null
      && isValidCreateContact(request.resource.data)
      && request.resource.data.uid == request.auth.uid;

      // createのバリデーション
      function isValidCreateContact(contact) {
        return contact.size() == 7
        && 'uid' in contact && contact.uid is string
				&& 'status' in contact && contact.status is string
        && 'email' in contact && contact.email is string
        && 'message' in contact && contact.message is string
        && 'memo' in contact && contact.memo is string
        && 'createdAt' in contact && contact.createdAt is timestamp
        && 'updatedAt' in contact && contact.updatedAt is timestamp;
      }
    }  
  }
}
```
