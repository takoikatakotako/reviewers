package handler

import (
	"admin/entity/template_data"
	"bytes"
	"github.com/labstack/echo/v4"
	"html/template"
	"net/http"
)

type Report struct{}

func (r *Report) ReportGet(c echo.Context) error {
	tmpl, err := template.ParseFS(f, "template/report.html", "template/header.html", "template/head.html", "template/footer.html")
	if err != nil {
		return err
	}

	reportTemplateData := template_data.Review{
		Header: &template_data.Header{Title: "Reviewers管理画面", Report: true},
	}

	var doc bytes.Buffer
	err = tmpl.Execute(&doc, reportTemplateData)
	if err != nil {
		return err
	}

	return c.HTML(http.StatusOK, doc.String())
}
