package database

import "time"

type Merchandise struct {
	Id        string
	CreatedAt time.Time `firestore:"createdAt,serverTimestamp"`
	Enable    bool      `firestore:"enable"`
	Name      string    `firestore:"name"`
	Status    string    `firestore:"status"`
	UpdatedAt time.Time `firestore:"updatedAt,serverTimestamp"`
}

//func (m *Merchandise) Data() map[string]interface{} {
//	return map[string]interface{}{
//		"createdAt": m.CreatedAt,
//		"enable":    m.Enable,
//		"name":      m.Name,
//		"status":    m.Status,
//		"updatedAt": m.UpdatedAt,
//	}
//}
