package handler

import (
	"admin/entity/template_data"
	"admin/service"
	"bytes"
	"github.com/labstack/echo/v4"
	"html/template"
	"net/http"
	"strconv"
)

type Review struct {
	Service service.Review
}

func (r *Review) ReviewGet(c echo.Context) error {
	page, err := strconv.Atoi(c.FormValue("page"))
	if err != nil {
		page = 1
	}

	reviews, err := r.Service.ReviewGet(page)
	if err != nil {
		return err
	}

	tmpl, err := template.ParseFS(f, "template/review.html")
	if err != nil {
		return err
	}

	reviewTemplateData := template_data.Review{
		Reviews: &reviews,
	}
	var doc bytes.Buffer
	err = tmpl.Execute(&doc, reviewTemplateData)
	if err != nil {
		return err
	}

	return c.HTML(http.StatusOK, doc.String())
}
