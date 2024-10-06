package handler

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

type Healthcheck struct{}

func (i *Healthcheck) HealthcheckGet(c echo.Context) error {
	return c.HTML(http.StatusOK, "healthy!!")
}
