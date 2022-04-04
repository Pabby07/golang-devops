package controllers

import (
	// Import the Gin library
	"github.com/gin-gonic/gin"
)

// HelloWorldController will hold the methods to the
type HealthCheckController struct{}

// Default controller handles returning the hello world JSON response
func (h *HealthCheckController) Healthcheck(c *gin.Context) {
	c.JSON(200, gin.H{"message": "the application is healthy"})
}
