package repository

import (
	"cloud.google.com/go/storage"
	"context"
	firebase "firebase.google.com/go/v4"
	"google.golang.org/api/option"
)

type FirebaseStorage struct {
	Credential []byte
}

func (s *FirebaseStorage) createApp() (*firebase.App, error) {
	config := &firebase.Config{}
	opt := option.WithCredentialsJSON(s.Credential)
	return firebase.NewApp(context.Background(), config, opt)
}

func (s *FirebaseStorage) CopyImage(sourcePath string, destinationPath string) error {
	app, err := s.createApp()
	if err != nil {
		return err
	}

	client, err := app.Storage(context.Background())
	if err != nil {
		return err
	}

	bucket, err := client.Bucket("reviewers-develop.appspot.com")
	if err != nil {
		return err
	}

	source := bucket.Object(sourcePath)
	destination := bucket.Object(destinationPath)

	destination = destination.If(storage.Conditions{DoesNotExist: true})
	_, err = destination.CopierFrom(source).Run(context.Background())
	if err != nil {
		return err
	}

	return nil
}
