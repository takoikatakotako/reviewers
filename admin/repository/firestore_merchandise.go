package repository

import (
	"admin/entity/database"
	"context"
	"google.golang.org/api/iterator"
)

func (f *Firestore) FetchMerchandises() ([]database.Merchandise, error) {
	app, err := f.createApp()
	if err != nil {
		return []database.Merchandise{}, err
	}

	client, err := app.Firestore(context.Background())
	if err != nil {
		return []database.Merchandise{}, err
	}
	merchandises := make([]database.Merchandise, 0)
	iter := client.Collection("merchandises").Limit(20).Documents(context.Background())
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
