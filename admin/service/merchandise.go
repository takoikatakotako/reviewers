package service

import (
	"admin/entity/template_data"
	"admin/repository"
)

type Merchandise struct {
	Environment repository.Environment
	Firestore   repository.Firestore
	Storage     repository.FirebaseStorage
}

func (m *Merchandise) MerchandiseGet(page int) ([]template_data.MerchandiseData, error) {
	merchandises, err := m.Firestore.FetchMerchandises(10, page)
	if err != nil {
		return []template_data.MerchandiseData{}, err
	}
	merchandiseDataList := convertMerchandises(merchandises)
	return merchandiseDataList, nil
}

func (m *Merchandise) MerchandiseReviewGet(merchandiseId string) (template_data.MerchandiseReview, error) {
	merchandise, err := m.Firestore.FetchMerchandise(merchandiseId)
	if err != nil {
		return template_data.MerchandiseReview{}, err
	}

	reviews, err := m.Firestore.FetchMerchandiseReviews(merchandise.Code)
	if err != nil {
		return template_data.MerchandiseReview{}, err
	}

	imageBaseUrl, err := m.Environment.GetImageBaseUrlString()
	if err != nil {
		return template_data.MerchandiseReview{}, err
	}
	reviewDataList := convertReviews(reviews, imageBaseUrl)
	return template_data.MerchandiseReview{
		Merchandise: convertMerchandise(merchandise),
		Reviews:     &reviewDataList,
	}, nil
}

func (m *Merchandise) MerchandiseReviewImageRegisterGet(merchandiseId string, reviewId string, image string) (template_data.MerchandiseReviewImageRegister, error) {
	merchandise, err := m.Firestore.FetchMerchandise(merchandiseId)
	if err != nil {
		return template_data.MerchandiseReviewImageRegister{}, err
	}

	review, err := m.Firestore.FetchReview(reviewId)
	if err != nil {
		return template_data.MerchandiseReviewImageRegister{}, err
	}

	imageBaseUrl, err := m.Environment.GetImageBaseUrlString()
	if err != nil {
		return template_data.MerchandiseReviewImageRegister{}, err
	}
	return template_data.MerchandiseReviewImageRegister{
		Merchandise: convertMerchandise(merchandise),
		Review:      convertReview(review, imageBaseUrl),
		Image: template_data.Image{
			Name: image,
			Url:  createReviewImageUrl(imageBaseUrl, review.Uid, image),
		},
	}, nil
}

func (m *Merchandise) MerchandiseReviewImageRegisterPost(merchandiseId string, reviewId string, image string) (template_data.MerchandiseReviewImageRegisterPost, error) {
	review, err := m.Firestore.FetchReview(reviewId)
	if err != nil {
		return template_data.MerchandiseReviewImageRegisterPost{}, err
	}
	// 画像をコピー
	sourcePath := "image/user/" + review.Uid + "/" + image
	destinationPath := "image/merchandise/" + image
	err = m.Storage.CopyImage(sourcePath, destinationPath)
	if err != nil {
		return template_data.MerchandiseReviewImageRegisterPost{}, err
	}

	// 更新
	err = m.Firestore.UpdateMerchandiseImage(merchandiseId, reviewId, image)
	if err != nil {
		return template_data.MerchandiseReviewImageRegisterPost{}, err
	}

	return template_data.MerchandiseReviewImageRegisterPost{}, nil
}
