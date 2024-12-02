package template_data

import "time"

type UserData struct {
	Uid           string
	ProviderId    string
	CreationTime  time.Time
	LastLoginTime time.Time
}
