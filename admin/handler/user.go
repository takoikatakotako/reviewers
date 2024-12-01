package handler

import (
	"admin/service"
	"bytes"
	"github.com/labstack/echo/v4"
	"html/template"
	"net/http"
)

type User struct {
	Service service.User
}

func (u *User) UserGet(c echo.Context) error {
	templateData, err := u.Service.UserGet()
	if err != nil {
		return err
	}
	tmpl, err := template.ParseFS(f, "template/user.html", "template/header.html", "template/head.html", "template/footer.html")
	if err != nil {
		return err
	}

	var doc bytes.Buffer
	err = tmpl.Execute(&doc, templateData)
	if err != nil {
		return err
	}

	return c.HTML(http.StatusOK, doc.String())
}

func (u *User) UserDetailGet(c echo.Context) error {
	userId := c.Param("userId")

	templateData, err := u.Service.UserDetailGet(userId)
	if err != nil {
		return err
	}
	tmpl, err := template.ParseFS(f, "template/user-detail.html", "template/header.html", "template/head.html", "template/footer.html")
	if err != nil {
		return err
	}

	var doc bytes.Buffer
	err = tmpl.Execute(&doc, templateData)
	if err != nil {
		return err
	}

	return c.HTML(http.StatusOK, doc.String())
}
