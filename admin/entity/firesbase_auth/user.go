package firesbase_auth

import "time"

type User struct {
	Uid           string
	ProviderId    string
	CreationTime  time.Time
	LastLoginTime time.Time
}
