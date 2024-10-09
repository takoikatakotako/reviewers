package handler

import (
	"bytes"
	"github.com/labstack/echo/v4"
	"html/template"
	"net/http"
)

type Report struct{}

func (r *Report) ReportGet(c echo.Context) error {
	tmpl, err := template.ParseFS(f, "template/report.html")
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
