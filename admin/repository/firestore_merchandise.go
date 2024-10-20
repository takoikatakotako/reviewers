package repository

import (
	"admin/entity/database"
	"cloud.google.com/go/firestore"
	"context"
	"google.golang.org/api/iterator"
	"time"
)

func (f *Firestore) FetchMerchandise(merchandiseId string) (database.Merchandise, error) {
	app, err := f.createApp()
	if err != nil {
		return database.Merchandise{}, err
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		return database.Merchandise{}, err
	}

	documentRef := client.Collection("merchandises").Doc(merchandiseId)
	doc, err := documentRef.Get(context.Background())
	var merchandise = database.Merchandise{}
	err = doc.DataTo(&merchandise)
	if err != nil {
		return database.Merchandise{}, err
	}
	merchandise.Id = doc.Ref.ID
	return merchandise, nil
}

func (f *Firestore) FetchMerchandises(limit int, page int) ([]database.Merchandise, error) {
	app, err := f.createApp()
	if err != nil {
		return []database.Merchandise{}, err
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		return []database.Merchandise{}, err
	}
	merchandises := make([]database.Merchandise, 0)

	offset := (page - 1) * limit
	iter := client.Collection("merchandises").OrderBy("createdAt", firestore.Desc).Offset(offset).Limit(limit).Documents(context.Background())
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			break
		}
		if err != nil {
			return []database.Merchandise{}, err
		}
		var merchandise = database.Merchandise{}
		err = doc.DataTo(&merchandise)
		if err != nil {
			return []database.Merchandise{}, err
		}
		merchandise.Id = doc.Ref.ID
		merchandises = append(merchandises, merchandise)
	}
	return merchandises, nil
}

func (f *Firestore) UpdateMerchandiseImage(merchandiseId string, reviewId string, image string) error {
	app, err := f.createApp()
	if err != nil {
		return err
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		return err
	}

	ctx := context.Background()
	updates := []firestore.Update{
		{Path: "updatedUid", Value: "ADMIN"},
		{Path: "updatedAt", Value: time.Now()},
		{Path: "image", Value: image},
		{Path: "imageReferenceReviewId", Value: reviewId},
	}

	_, err = client.Collection("merchandises").Doc(merchandiseId).Update(ctx, updates)
	if err != nil {
		return err
	}

	return nil
}
