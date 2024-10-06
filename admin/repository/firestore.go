package repository

import (
	"context"
	firebase "firebase.google.com/go/v4"
	"google.golang.org/api/option"
)

type Firestore struct {
	Credential []byte
}

func (f *Firestore) createApp() (*firebase.App, error) {
	config := &firebase.Config{}
	opt := option.WithCredentialsJSON(f.Credential)
	return firebase.NewApp(context.Background(), config, opt)
}
