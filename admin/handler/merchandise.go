package handler

import (
	"bytes"
	"github.com/labstack/echo/v4"
	"html/template"
	"net/http"
)

type Merchandise struct{}

func (m *Merchandise) MerchandiseGet(c echo.Context) error {
	tmpl, err := template.ParseFS(f, "template/merchandise.html")
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
