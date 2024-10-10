package service

import (
	"admin/entity/template_data"
	"admin/repository"
)

type Review struct {
	Environment repository.Environment
	Firestore   repository.Firestore
}

func (r *Review) ReviewGet(page int) ([]template_data.ReviewData, error) {
	// fetch reviews
	reviews, err := r.Firestore.FetchReviews(10, page)
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
