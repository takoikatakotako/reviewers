package handler

import (
	"bytes"
	"github.com/labstack/echo/v4"
	"html/template"
	"net/http"
)

type Review struct{}

func (i *Review) ReviewGet(c echo.Context) error {
	tmpl, err := template.ParseFS(f, "template/review.html")
	if err != nil {
		return err
	}

	var doc bytes.Buffer
	err = tmpl.Execute(&doc, nil)
	if err != nil {
		return err
	}

	return c.HTML(http.StatusOK, doc.String())
}
