package main

import (
	"docker_dev-container/src"

	"github.com/a-h/templ"
	"github.com/labstack/echo/v4"
)

type MiscHandler struct{}

func (h MiscHandler) Base(c echo.Context) error {
	return RenderComponent(c, src.Base())
}

func RenderComponent(c echo.Context, component templ.Component) error {
	return component.Render(c.Request().Context(), c.Response())
}

func main() {
	// Create a new Echo instance
	app := echo.New()

	//repository.Connect()

	miscHandler := MiscHandler{}
	app.GET("/", miscHandler.Base)

	// Start the server
	app.Logger.Fatal(app.Start(":3000"))
}
