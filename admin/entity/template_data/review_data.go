package template_data

import "time"

type ReviewData struct {
	Id        string
	Code      string
	Comment   string
	CreatedAt time.Time
	Deleted   bool
	ImageUrls []string
	Rate      int
	Uid       string
	UpdatedAt time.Time
}
