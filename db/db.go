package db

import (
	"fmt"
	"os"
	"time"

	// "os"

	"gopkg.in/mgo.v2"
)

// DBConnection defines the connection structure
type DBConnection struct {
	session *mgo.Session
}

// NewConnection handles connecting to a mongo database
func NewConnection(host string, dbName string) (conn *DBConnection) {
	info := &mgo.DialInfo{
		// Address if its a local db then the value host=localhost
		// Addrs: []string{host},
		Addrs: []string{os.Getenv("MONGO_URL")},
		// Timeout when a failure to connect to db
		Timeout: 45 * time.Second,
		// Database name
		Database: dbName,
		// Database credentials if your db is protected
		Username: os.Getenv("DB_USER"),
		Password: os.Getenv("DB_PWD"),
	}
	fmt.Println("INFO CONN ", info)
	fmt.Println("Initiating connection with mongo on url:", info.Addrs)
	session, err := mgo.DialWithInfo(info)

	// url :=
	// // url := "13.56.150.54:27017"
	// fmt.Printf("[%v]\n", url)
	// session, err := mgo.Dial(url)
	if err != nil {
		panic(err)
	}
	fmt.Println("ping", session.Ping())
	fmt.Println("Session started")
	if err != nil {
		panic(err)
	}

	session.SetMode(mgo.Monotonic, true)
	conn = &DBConnection{session}
	return conn
}

// Use handles connect to a certain collection
func (conn *DBConnection) Use(dbName, tableName string) (collection *mgo.Collection) {
	// This returns method that interacts with a specific collection and table
	return conn.session.DB(dbName).C(tableName)
}

// Close handles closing a database connection
func (conn *DBConnection) Close() {
	// This closes the connection
	conn.session.Close()
	return
}
