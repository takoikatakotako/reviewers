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

type Merchandise struct {
	Service service.Merchandise
}

func (m *Merchandise) MerchandiseGet(c echo.Context) error {
	page, err := strconv.Atoi(c.FormValue("page"))
	if err != nil {
		page = 1
	}
	merchandises, err := m.Service.MerchandiseGet(page)
	if err != nil {
		return err
	}

	tmpl, err := template.ParseFS(f, "template/merchandise.html")
	if err != nil {
		return err
	}

	reviewTemplateData := template_data.Merchandise{
		Merchandises: &merchandises,
	}
	var doc bytes.Buffer
	err = tmpl.Execute(&doc, reviewTemplateData)
	if err != nil {
		return err
	}

	return c.HTML(http.StatusOK, doc.String())
}

func (m *Merchandise) MerchandiseReviewGet(c echo.Context) error {
	merchandiseCode := c.Param("code")
	templateData, err := m.Service.MerchandiseReviewGet(merchandiseCode)
	if err != nil {
		return err
	}

	tmpl, err := template.ParseFS(f, "template/merchandise-review.html")
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
