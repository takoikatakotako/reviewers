package database

import "time"

type Review struct {
	Id        string
	Code      string    `firestore:"code"`
	Comment   string    `firestore:"comment"`
	CreatedAt time.Time `firestore:"createdAt,serverTimestamp"`
	Deleted   bool      `firestore:"deleted"`
	Images    []string  `firestore:"images"`
	Rate      int       `firestore:"rate"`
	Uid       string    `firestore:"uid"`
	UpdatedAt time.Time `firestore:"updatedAt,serverTimestamp"`
}

//func (a *Review) Data() map[string]interface{} {
//	return map[string]interface{}{
//		"code":      a.Code,
//		"comment":   a.Comment,
//		"createdAt": a.CreatedAt,
//		"deleted":   a.Deleted,
//		"images":    a.Images,
//		"rate":      a.Rate,
//		"uid":       a.Uid,
//		"updatedAt": a.UpdatedAt,
//	}
//}
