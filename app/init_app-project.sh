# go get dependencies watch here for full name: https://pkg.go.dev/

# remove go.mod file
rm go.mod
# remove go.sum file
rm go.sum
# init the file go.mod
go mod init docker_dev-container
# add latest "echo" version to go.mod file
# USAGE: Used to provide a webserver
go get github.com/labstack/echo/v4
go get github.com/labstack/echo/v4/middleware
# install latest "templ" version
# USAGE: HTML serverside rendering
go get github.com/a-h/templ/cmd/templ@latest
# install latest "pgx" version
# USAGE: Connecting to PostgreSQL-Database
go get github.com/jackc/pgx/v5
# Updates all modules that are dependencies the project to their latest versions.
go get -u
# cleanup
# remove unused dependencies
# add missing dependencies
# update sum.go
go mod tidy