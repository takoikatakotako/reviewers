package database

import "time"

type Merchandise struct {
	Id        string
	CreatedAt time.Time
	Enable    bool
	Name      string
	Status    string
	UpdatedAt time.Time
}

func (m *Merchandise) Data() map[string]interface{} {
	return map[string]interface{}{
		"createdAt": m.CreatedAt,
		"enable":    m.Enable,
		"name":      m.Name,
		"status":    m.Status,
		"updatedAt": m.UpdatedAt,
	}
}
