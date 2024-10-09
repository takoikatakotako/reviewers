package service

import (
	"admin/entity/template_data"
	"admin/repository"
)

type Review struct {
	Environment repository.Environment
	Firestore   repository.Firestore
}

func (r *Review) ReviewGet() ([]template_data.ReviewData, error) {
	// fetch reviews
	reviews, err := r.Firestore.FetchReviews()
	if err != nil {
		return []template_data.ReviewData{}, err
	}

	// get image base url
	imageBaseUrl, err := r.Environment.GetImageBaseUrlString()
	if err != nil {
		return []template_data.ReviewData{}, err
	}

	reviewDataList := convertReviews(reviews, imageBaseUrl)
	return reviewDataList, nil
}
