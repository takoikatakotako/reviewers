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

	tmpl, err := template.ParseFS(f, "template/review.html", "template/header.html", "template/head.html", "template/footer.html")
	if err != nil {
		return err
	}

	reviewTemplateData := template_data.Review{
		Header:  &template_data.Header{Title: "Reviewers管理画面", Review: true},
		Reviews: &reviews,
	}
	var doc bytes.Buffer
	err = tmpl.Execute(&doc, reviewTemplateData)
	if err != nil {
		return err
	}

	return c.HTML(http.StatusOK, doc.String())
}
