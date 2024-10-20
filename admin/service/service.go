package service

import (
	"admin/entity/database"
	"admin/entity/template_data"
)

func convertReviews(databaseReviews []database.Review, imageBaseUrl string) []template_data.ReviewData {
	reviewDataList := make([]template_data.ReviewData, 0)
	for _, v := range databaseReviews {
		reviewData := convertReview(v, imageBaseUrl)
		reviewDataList = append(reviewDataList, reviewData)
	}
	return reviewDataList
}

func convertReview(databaseReview database.Review, imageBaseUrl string) (templateReview template_data.ReviewData) {
	var imageUrls = make([]string, 0)
	for _, v := range databaseReview.Images {
		imageUrl := imageBaseUrl + "user/" + databaseReview.Uid + "/" + v
		imageUrls = append(imageUrls, imageUrl)
	}

	return template_data.ReviewData{
		Id:        databaseReview.Id,
		Code:      databaseReview.Code,
		Comment:   databaseReview.Comment,
		CreatedAt: databaseReview.CreatedAt,
		Deleted:   databaseReview.Deleted,
		Images:    databaseReview.Images,
		ImageUrls: imageUrls,
		Rate:      databaseReview.Rate,
		Uid:       databaseReview.Uid,
		UpdatedAt: databaseReview.UpdatedAt,
	}
}

func convertMerchandises(databaseMerchandises []database.Merchandise) []template_data.MerchandiseData {
	merchandiseDataList := make([]template_data.MerchandiseData, 0)
	for _, v := range databaseMerchandises {
		merchandiseData := convertMerchandise(v)
		merchandiseDataList = append(merchandiseDataList, merchandiseData)
	}
	return merchandiseDataList
}

func convertMerchandise(databaseMerchandise database.Merchandise) (templateReview template_data.MerchandiseData) {
	return template_data.MerchandiseData{
		Id:        databaseMerchandise.Id,
		Code:      databaseMerchandise.Code,
		CodeType:  databaseMerchandise.CodeType,
		CreatedAt: databaseMerchandise.CreatedAt,
		Enable:    databaseMerchandise.Enable,
		Name:      databaseMerchandise.Name,
		Status:    databaseMerchandise.Status,
		UpdatedAt: databaseMerchandise.UpdatedAt,
	}
}
