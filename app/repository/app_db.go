package repository

import (
	"fmt"
	"os"
)

func Connect() {
	// urlExample := "postgres://username:password@localhost:5432/database_name"
	//urlExample := "postgres://pg:pgpw@localhost:5001/dev_container"
	databaseURL := "postgres://" + os.Getenv("DB_CLIENT_USER") + ":" + os.Getenv("DB_CLIENT_PASSWORD") + ":5001/" + os.Getenv("DB_CLIENT_PASSWORD")
	fmt.Printf(databaseURL)

	//conn, err := pgx.Connect(context.Background(), databaseURL)
	//if err != nil {
	//	fmt.Fprintf(os.Stderr, "Unable to connect to database: %v\n", err)
	//}
	//defer conn.Close(context.Background())

	//var name string
	//var weight int64
	//err = conn.QueryRow(context.Background(), "select name, weight from widgets where id=$1", 42).Scan(&name, &weight)
	//if err != nil {
	//	fmt.Fprintf(os.Stderr, "QueryRow failed: %v\n", err)
	//	os.Exit(1)
	//}

	//fmt.Println(name, weight)
}
