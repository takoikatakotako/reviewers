package template_data

type MerchandiseReview struct {
	MerchandiseCode string
	Reviews         *[]ReviewData
	ImageBaseUrl    string
}
