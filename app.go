package main

import (
	// Log items to the terminal
	// Import gin for route definition
	"github.com/gin-gonic/gin"

	// "github.com/google/martian/log"
	"github.com/sirupsen/logrus"
	log "github.com/sirupsen/logrus"

	// Import godotenv for .env variables
	"github.com/joho/godotenv"
	// Import our app controllers
	// "github.com/tesh254/golang_todo_api/controllers"
	"github.com/Pabby07/golang-training/controllers"
)

// init gets called before the main function
func init() {
	log := logrus.New()
	// Log error if .env file does not exist
	if err := godotenv.Load(); err != nil {
		log.Errorf("No .env file found")
	}
}

func main() {

	// Init gin router

	log.Info("App started")

	router := gin.Default()

	v1 := router.Group("/api/v1")
	{
		// // Define the hello controller
		hello := new(controllers.HelloWorldController)
		// // Define a GET request to call the Default
		// // method in controllers/hello.go
		v1.GET("/hello", hello.Default)
		user := new(controllers.UserController)
		// Create the signup endpoint
		// log.Info("App asidguasdiuasgdfiugasiu")
		v1.POST("/signup", user.Signup)
	}
	health := new(controllers.HealthCheckController)
	router.GET("/", health.Healthcheck)
	// Handle error response when a route is not defined
	router.NoRoute(func(c *gin.Context) {
		// In gin this is how you return a JSON response
		c.JSON(404, gin.H{"message": "Not found"})
	})

	// Init our server
	router.Run(":5500")
}
