package service

import (
	"admin/repository"
	"fmt"
)

type Review struct {
	Repository repository.Firestore
}

func (r *Review) ReviewGet() error {
	reviews, err := r.Repository.FetchReview()
	if err != nil {
		return err
	}
	fmt.Print(reviews)
	return nil
}
