package template_data

import "time"

type MerchandiseData struct {
	Id        string
	Code      string
	CodeType  string
	CreatedAt time.Time
	Enable    bool
	Name      string
	Status    string
	UpdatedAt time.Time
}
