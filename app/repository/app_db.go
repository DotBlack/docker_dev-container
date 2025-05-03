package repository

import (
	"context"
	"fmt"
	"os"

	"github.com/jackc/pgx/v5"
)

func Connect() {
	databaseURL := "postgres://" + os.Getenv("DB_CLIENT_USER") + ":" + os.Getenv("DB_CLIENT_PASSWORD") + "@postgres:" + os.Getenv("DB_PORT") + "/" + os.Getenv("POSTGRES_DB")

	conn, err := pgx.Connect(context.Background(), databaseURL)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
	} else {
		fmt.Printf("Connection to database 'db' successfully established with user %s", os.Getenv("DB_CLIENT_USER"))
	}
	defer conn.Close(context.Background())
}
