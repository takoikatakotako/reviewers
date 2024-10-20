package service

import (
	"admin/entity/template_data"
	"admin/repository"
)

type Merchandise struct {
	Environment repository.Environment
	Firestore   repository.Firestore
}

func (m *Merchandise) MerchandiseGet(page int) ([]template_data.MerchandiseData, error) {
	merchandises, err := m.Firestore.FetchMerchandises(10, page)
	if err != nil {
		return []template_data.MerchandiseData{}, err
	}
	merchandiseDataList := convertMerchandises(merchandises)
	return merchandiseDataList, nil
}

func (m *Merchandise) MerchandiseReviewGet(merchandiseCode string) (template_data.MerchandiseReview, error) {
	reviews, err := m.Firestore.FetchMerchandiseReviews(merchandiseCode)
	if err != nil {
		return template_data.MerchandiseReview{}, err
	}

	imageBaseUrl, err := m.Environment.GetImageBaseUrlString()
	if err != nil {
		return template_data.MerchandiseReview{}, err
	}
	reviewDataList := convertReviews(reviews, imageBaseUrl)
	return template_data.MerchandiseReview{
		MerchandiseCode: merchandiseCode,
		Reviews:         &reviewDataList,
		ImageBaseUrl:    imageBaseUrl,
	}, nil
}
