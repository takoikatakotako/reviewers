package main

import (
	"admin/handler"
	"admin/repository"
	"fmt"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"log"
	"os"
)

func main() {
	var credential []byte
	credential, err := os.ReadFile("reviewers-develop-firebase-adminsdk-7qe7x-54469c07aa.json")
	if err != nil {
		log.Fatal("credential file not found")
	}

	// Repository
	repo := repository.Firestore{
		Credential: credential,
	}

	reviews, err := repo.FetchReview()
	if err != nil {
		log.Fatal("credential file not found")
	}
	fmt.Print(reviews)

	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Handler
	index := handler.Index{}
	healthcheck := handler.Healthcheck{}
	review := handler.Review{}

	// Routes
	e.GET("/", index.IndexGet)
	e.GET("/healthcheck/", healthcheck.HealthcheckGet)
	e.GET("/review/", review.ReviewGet)

	// Start server
	e.Logger.Fatal(e.Start(":8888"))
}
