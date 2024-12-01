package repository

import (
	"admin/entity/firesbase_auth"
	"context"
	firebase "firebase.google.com/go/v4"
	"firebase.google.com/go/v4/auth"
	"google.golang.org/api/iterator"
	"google.golang.org/api/option"
	"time"
)

type FirebaseAuth struct {
	Credential []byte
}

func (s *FirebaseAuth) createApp() (*firebase.App, error) {
	config := &firebase.Config{}
	opt := option.WithCredentialsJSON(s.Credential)
	return firebase.NewApp(context.Background(), config, opt)
}

func (s *FirebaseAuth) FetchUsers() ([]firesbase_auth.User, error) {
	app, err := s.createApp()
	if err != nil {
		return []firesbase_auth.User{}, err
	}

	client, err := app.Auth(context.Background())
	if err != nil {
		return []firesbase_auth.User{}, err
	}

	firestoreUsers := make([]firesbase_auth.User, 0)
	iter := client.Users(context.Background(), "")
	pager := iterator.NewPager(iter, 100, "")
	for {
		var users []*auth.ExportedUserRecord
		nextPageToken, err := pager.NextPage(&users)
		if err != nil {
			return []firesbase_auth.User{}, err
		}
		for _, user := range users {
			firestoreUsers = append(firestoreUsers, firesbase_auth.User{
				Uid:           user.UID,
				ProviderId:    user.UserInfo.ProviderID,
				CreationTime:  time.Unix(user.UserMetadata.CreationTimestamp/1000, 0),
				LastLoginTime: time.Unix(user.UserMetadata.LastLogInTimestamp/1000, 0),
			})
		}
		if nextPageToken == "" {
			break
		}

		// 1000人以上で一度切る
		if len(firestoreUsers) > 1000 {
			break
		}
	}
	return firestoreUsers, nil
}
