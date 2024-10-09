package service

import (
	"admin/entity/template_data"
	"admin/repository"
)

type Merchandise struct {
	Environment repository.Environment
	Firestore   repository.Firestore
}

func (m *Merchandise) MerchandiseGet() ([]template_data.MerchandiseData, error) {
	merchandises, err := m.Firestore.FetchMerchandises()
	if err != nil {
		return []template_data.MerchandiseData{}, err
	}
	merchandiseDataList := convertMerchandises(merchandises)
	return merchandiseDataList, nil
}

func (m *Merchandise) MerchandiseReviewGet(merchandiseId string) (template_data.MerchandiseReview, error) {
	reviews, err := m.Firestore.FetchMerchandiseReviews(merchandiseId)
	if err != nil {
		return template_data.MerchandiseReview{}, err
	}

	imageBaseUrl, err := m.Environment.GetImageBaseUrlString()
	if err != nil {
		return template_data.MerchandiseReview{}, err
	}
	reviewDataList := convertReviews(reviews, imageBaseUrl)
	return template_data.MerchandiseReview{
		Reviews: &reviewDataList,
	}, nil
}
