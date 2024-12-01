package service

import (
	"admin/entity/template_data"
	"admin/repository"
)

type User struct {
	Environment  repository.Environment
	FirebaseAuth repository.FirebaseAuth
}

func (u *User) UserGet() (template_data.User, error) {
	// get title
	title, err := u.Environment.GetTitle()
	if err != nil {
		return template_data.User{}, err
	}

	// fetch reviews
	authUsers, err := u.FirebaseAuth.FetchUsers()
	if err != nil {
		return template_data.User{}, err
	}
	
	users := convertAuthUsers(authUsers)
	return template_data.User{
		Header: &template_data.Header{Title: title, User: true},
		Users:  &users,
	}, nil
}
