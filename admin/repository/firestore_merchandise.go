package repository

import (
	"admin/entity/database"
	"cloud.google.com/go/firestore"
	"context"
	"google.golang.org/api/iterator"
)

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
