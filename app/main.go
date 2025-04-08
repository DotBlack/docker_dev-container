package main

import (
	"github.com/a-h/templ"
	"github.com/labstack/echo/v4"
)

type MiscHandler struct{}

func (h MiscHandler) Base(c echo.Context) error {
	return RenderComponent(c, Base())
}

func RenderComponent(c echo.Context, component templ.Component) error {
	return component.Render(c.Request().Context(), c.Response())
}

func main() {
	// Create a new Echo instance
	app := echo.New()

	miscHandler := MiscHandler{}
	app.GET("/", miscHandler.Base)

	// Start the server
	app.Logger.Fatal(app.Start(":8080"))
}
