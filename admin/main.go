package main

import (
	"admin/handler"
	"admin/repository"
	"admin/service"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"log"
	"os"
)

func main() {
	// Firebase
	var credential, err = os.ReadFile("reviewers-develop-firebase-adminsdk-7qe7x-54469c07aa.json")
	if err != nil {
		log.Fatal("credential file not found")
	}

	// Firestore
	environmentRepository := repository.Environment{
		FileName: "config.json",
	}
	firestoreRepository := repository.Firestore{
		Credential: credential,
	}
	storageRepository := repository.FirebaseStorage{
		Credential: credential,
	}

	// Service
	reviewService := service.Review{
		Environment: environmentRepository,
		Firestore:   firestoreRepository,
	}
	merchandiseService := service.Merchandise{
		Environment: environmentRepository,
		Firestore:   firestoreRepository,
		Storage:     storageRepository,
	}

	// Handler
	index := handler.Index{}
	healthcheck := handler.Healthcheck{}
	review := handler.Review{
		Service: reviewService,
	}
	merchandise := handler.Merchandise{
		Service: merchandiseService,
	}
	report := handler.Report{}

	// Echo instance
	e := echo.New()

	// Middleware
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	// Routes
	e.GET("/", index.IndexGet)
	e.GET("/healthcheck/", healthcheck.HealthcheckGet)
	e.GET("/merchandise/", merchandise.MerchandiseGet)
	e.GET("/merchandise/:merchandiseId/review/", merchandise.MerchandiseReviewGet)
	e.GET("/merchandise/:merchandiseId/review/:reviewId/image/:image/register/", merchandise.MerchandiseReviewImageRegisterGet)
	e.POST("/merchandise/:merchandiseId/review/:reviewId/image/:image/register/", merchandise.MerchandiseReviewImageRegisterPost)

	e.GET("/report/", report.ReportGet)
	e.GET("/review/", review.ReviewGet)

	// Start server
	e.Logger.Fatal(e.Start(":8888"))
}
