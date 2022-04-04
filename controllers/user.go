package controllers

import (
	"github.com/Pabby07/golang-training/forms"
	"github.com/Pabby07/golang-training/models"
	"github.com/gin-gonic/gin"

	// "github.com/google/martian/log"
	log "github.com/sirupsen/logrus"
)

// Import the userModel from the models
var userModel = new(models.UserModel)

// UserController defines the user controller methods
type UserController struct{}

// Signup controller handles registering a user
func (u *UserController) Signup(c *gin.Context) {
	var data forms.SignupUserCommand
	// fmt.Println("entered Signup")
	// log.Info("Entered Signup functionality")
	// Bind the data from the request body to the SignupUserCommand Struct
	// Also check if all fields are provided
	if c.BindJSON(&data) != nil {
		// specified response
		c.JSON(406, gin.H{"message": "Provide relevant fields"})
		// abort the request
		c.Abort()
		// return nothing
		return
	}
	log.Info("Req Data not empty")
	// log.Print("Post Data not empty")
	/*
	   You can add your validation logic
	   here such as email

	   if regexMethodChecker(data.Email) {
	       c.JSON(400, gin.H{"message": "Email is invalid"})
	       c.Abort()
	       return
	   }
	*/
	result, _ := userModel.GetUserByEmail(data.Email)
	// If there happens to be a result respond with a
	// descriptive mesage
	if result.Email != "" {
		c.JSON(403, gin.H{"message": "Email is already in use"})
		c.Abort()
		return
	}
	log.Info("User not already present in db")
	// log.Print("User not present in the DB")

	err := userModel.Signup(data)

	// Check if there was an error when saving user
	if err != nil {
		c.JSON(400, gin.H{"message": "Problem creating an account"})
		c.Abort()
		return
	}

	c.JSON(201, gin.H{"message": "New user account registered"})
}
