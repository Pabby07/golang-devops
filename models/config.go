package models

import (
	"os"

	"github.com/Pabby07/golang-training/db"
)

// Mongo server ip -> localhost -> 127.0.0.1 -> 0.0.0.0
// var server = os.Getenv("DATABASE")
// var server = os.Getenv("localhost")

// Database name
// var databaseName = os.Getenv("DATABASE_NAME")
var databaseName = os.Getenv("UsermanagementSystem")

// Create a connection
var dbConnect = db.NewConnection("localhost", databaseName)
