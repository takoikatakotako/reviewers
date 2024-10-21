package repository

import (
	"admin/entity/database"
	"cloud.google.com/go/firestore"
	"context"
	"google.golang.org/api/iterator"
)

func (f *Firestore) FetchReview(reviewId string) (database.Review, error) {
	app, err := f.createApp()
	if err != nil {
		return database.Review{}, err
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		return database.Review{}, err
	}

	documentRef := client.Collection("reviews").Doc(reviewId)
	doc, err := documentRef.Get(context.Background())
	var review = database.Review{}
	err = doc.DataTo(&review)
	if err != nil {
		return database.Review{}, err
	}
	review.Id = doc.Ref.ID
	return review, nil
}

func (f *Firestore) FetchReviews(limit int, page int) ([]database.Review, error) {
	app, err := f.createApp()
	if err != nil {
		return []database.Review{}, err
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		return []database.Review{}, err
	}

	offset := (page - 1) * limit
	iter := client.Collection("reviews").OrderBy("createdAt", firestore.Desc).Offset(offset).Limit(limit).Documents(context.Background())

	reviews := make([]database.Review, 0)
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return []database.Review{}, err
		}
		var review = database.Review{}
		err = doc.DataTo(&review)
		if err != nil {
			return []database.Review{}, err
		}
		review.Id = doc.Ref.ID
		reviews = append(reviews, review)
	}
	return reviews, nil
}

func (f *Firestore) FetchMerchandiseReviews(merchandiseCode string) ([]database.Review, error) {
	app, err := f.createApp()
	if err != nil {
		return []database.Review{}, err
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		return []database.Review{}, err
	}
	reviews := make([]database.Review, 0)
	iter := client.Collection("reviews").Where("code", "==", merchandiseCode).Limit(20).Documents(context.Background())
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return []database.Review{}, err
		}
		var review = database.Review{}
		err = doc.DataTo(&review)
		if err != nil {
			return []database.Review{}, err
		}
		review.Id = doc.Ref.ID
		reviews = append(reviews, review)
	}
	return reviews, nil
}
