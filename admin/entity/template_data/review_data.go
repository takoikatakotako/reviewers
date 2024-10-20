package template_data

import "time"

type ReviewData struct {
	Id        string
	Code      string
	Comment   string
	CreatedAt time.Time
	Deleted   bool
	Images    []string
	ImageUrls []string
	Rate      int
	Uid       string
	UpdatedAt time.Time
}
