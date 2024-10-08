package database

import "time"

type Review struct {
	Id        string
	Code      string
	Comment   string
	CreatedAt time.Time
	Deleted   bool
	Images    []string
	Rate      int
	Uid       string
	UpdatedAt time.Time
}

func (a *Review) Data() map[string]interface{} {
	return map[string]interface{}{
		"code":      a.Code,
		"comment":   a.Comment,
		"createdAt": a.CreatedAt,
		"deleted":   a.Deleted,
		"images":    a.Images,
		"rate":      a.Rate,
		"uid":       a.Uid,
		"updatedAt": a.UpdatedAt,
	}
}
