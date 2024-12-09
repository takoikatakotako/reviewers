package main

import (
	"context"
	firebase "firebase.google.com/go"
	"google.golang.org/api/option"
	"log"
	"os"
	"time"
)

func main() {
	// Firebase
	var credential, err = os.ReadFile("reviewers-develop-firebase-adminsdk-7qe7x-54469c07aa.json")
	if err != nil {
		log.Fatal("credential file not found")
	}

	config := &firebase.Config{}
	opt := option.WithCredentialsJSON(credential)
	app, err := firebase.NewApp(context.Background(), config, opt)
	if err != nil {
		log.Fatal("failed to create app")
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		log.Fatal("failed to create app client")
	}

	//// Reviews Validate
	//reviews, err := client.Collection("reviews").Documents(context.Background()).GetAll()
	//if err != nil {
	//	log.Fatalf("Failed to get documents: %v", err)
	//}
	//
	//for _, review := range reviews {
	//	log.Printf("--------------------\n")
	//	log.Printf("id: %s\n", review.Ref.ID)
	//
	//	data := review.Data()
	//
	//	if len(data) != 9 {
	//		log.Fatalf("The number of fields does not match, id: %s", review.Ref.ID)
	//	}
	//
	//	if uid, ok := data["uid"].(string); ok {
	//		log.Printf("uid: %s\n", uid)
	//	} else {
	//		log.Fatalf("uid is not exist")
	//	}
	//
	//	if deleted, ok := data["deleted"].(bool); ok {
	//		log.Printf("deleted: %t\n", deleted)
	//	} else {
	//		log.Fatalf("deleted is not exist")
	//	}
	//
	//	if code, ok := data["code"].(string); ok {
	//		log.Printf("code: %s\n", code)
	//	} else {
	//		log.Fatalf("code is not exist")
	//	}
	//
	//	if codeType, ok := data["codeType"].(string); ok {
	//		log.Printf("codeType: %s\n", codeType)
	//	} else {
	//		log.Fatalf("codeType is not exist")
	//	}
	//
	//	if comment, ok := data["comment"].(string); ok {
	//		log.Printf("comment: %s\n", comment)
	//	} else {
	//		log.Fatalf("comment is not exist")
	//	}
	//
	//	if interfaceImages, ok := data["images"].([]interface{}); ok {
	//		// 文字列の配列に変換
	//		var images []string
	//		for _, interfaceImage := range interfaceImages {
	//			if str, ok := interfaceImage.(string); ok {
	//				images = append(images, str)
	//			} else {
	//				log.Fatalf("image is not string")
	//			}
	//		}
	//		log.Printf("images: %s\n", images)
	//	} else {
	//		log.Fatalf("images is not exist")
	//	}
	//
	//	if rate, ok := data["rate"].(int64); ok {
	//		if 1 <= rate && rate <= 5 {
	//			log.Printf("rate: %d\n", rate)
	//		} else {
	//			log.Fatalf("rate invalid value")
	//		}
	//	} else {
	//		log.Fatalf("rate is not exist")
	//	}
	//
	//	if createdAt, ok := data["createdAt"].(time.Time); ok {
	//		log.Printf("createdAt: %s\n", createdAt)
	//	} else {
	//		log.Fatalf("createdAt is not exist")
	//	}
	//
	//	if updatedAt, ok := data["updatedAt"].(time.Time); ok {
	//		log.Printf("updatedAt: %s\n", updatedAt)
	//	} else {
	//		log.Fatalf("updatedAt is not exist")
	//	}

	// Merchandises Validate
	merchandises, err := client.Collection("merchandises").Documents(context.Background()).GetAll()
	if err != nil {
		log.Fatalf("Failed to get documents: %v", err)
	}

	for _, merchandise := range merchandises {
		log.Printf("--------------------\n")
		log.Printf("id: %s\n", merchandise.Ref.ID)

		data := merchandise.Data()

		if len(data) != 11 {
			log.Fatalf("The number of fields does not match, id: %s", merchandise.Ref.ID)
		}

		if name, ok := data["name"].(string); ok {
			log.Printf("name: %s\n", name)
		} else {
			log.Fatalf("name is not exist")
		}

		if deleted, ok := data["enable"].(bool); ok {
			log.Printf("enable: %t\n", deleted)
		} else {
			log.Fatalf("enable is not exist")
		}

		if code, ok := data["code"].(string); ok {
			log.Printf("code: %s\n", code)
		} else {
			log.Fatalf("code is not exist")
		}

		if codeType, ok := data["codeType"].(string); ok {
			log.Printf("codeType: %s\n", codeType)
		} else {
			log.Fatalf("codeType is not exist")
		}

		if status, ok := data["status"].(string); ok {
			log.Printf("status: %s\n", status)
		} else {
			log.Fatalf("status is not exist")
		}

		if image, ok := data["image"].(string); ok {
			log.Printf("image: %s\n", image)
		} else {
			log.Fatalf("image is not exist")
		}

		if imageReferenceReviewId, ok := data["imageReferenceReviewId"].(string); ok {
			log.Printf("imageReferenceReviewId: %s\n", imageReferenceReviewId)
		} else {
			log.Fatalf("imageReferenceReviewId is not exist")
		}

		if createdAt, ok := data["createdAt"].(time.Time); ok {
			log.Printf("createdAt: %s\n", createdAt)
		} else {
			log.Fatalf("createdAt is not exist")
		}

		if createdUid, ok := data["createdUid"].(string); ok {
			log.Printf("createdUid: %s\n", createdUid)
		} else {
			log.Fatalf("createdUid is not exist")
		}

		if updatedAt, ok := data["updatedAt"].(time.Time); ok {
			log.Printf("updatedAt: %s\n", updatedAt)
		} else {
			log.Fatalf("updatedAt is not exist")
		}

		if updatedUid, ok := data["updatedUid"].(string); ok {
			log.Printf("updatedUid: %s\n", updatedUid)
		} else {
			log.Fatalf("updatedUid is not exist")
		}

		//update := []firestore.Update{
		//	{
		//		Path:  "deleted",
		//		Value: firestore.Delete,
		//	},
		//}
		//
		//_, err = client.Collection("merchandises").Doc(merchandise.Ref.ID).Update(context.Background(), update)
		//if err != nil {
		//	return
		//}

		//update := []firestore.Update{
		//	{
		//		Path:  "imageRefarenceReviewId",
		//		Value: firestore.Delete,
		//	},
		//}
		//
		//_, err = client.Collection("merchandises").Doc(merchandise.Ref.ID).Update(context.Background(), update)
		//if err != nil {
		//	return
		//}

	}
}
