# use the alpine linux image as base
FROM golang:1.23-alpine

# apk = alpine package manager
# add = add package from git
# --no-cache = don't keep a copy on the system to prevent downloading in future
## run apk update
RUN apk update
## install git on alpine linux
RUN apk add git
## install go on alpine linux
RUN apk add go

# Configure Paths
## App-Path
ENV APPPATH=/app
# Go-Path
ENV GOROOT=/usr/lib/go
ENV GOPATH=/go
ENV PATH=/go/bin:$PATH

# organize code in the image inside the working-directory app
WORKDIR ${APPPATH}

# test for go.mod file || init the file only if first command succeeds
RUN test -f go.mod || echo "You must run init_project.sh first!"
# copy any go.* files into the image
# (files go.mod and go.sum if present)
COPY go.* ./
# download go dependencies & perform cleanup on go dependencies
RUN go mod download && go mod tidy

# install latest "air" version
# USAGE: automated build and reload of the app in developement
# https://github.com/air-verse/air?tab=readme-ov-file#installation-and-usage-for-docker-users-who-dont-want-to-use-air-image
RUN go install github.com/air-verse/air@latest
# install latest "gopls" version (go please)
# USAGE: offical Go language server - provides IDE-like features for Go development environments
# https://pkg.go.dev/golang.org/x/tools/gopls#section-readme
RUN go install golang.org/x/tools/gopls@latest
# install latest "templ" version
# USAGE: HTML serverside rendering
RUN go install github.com/a-h/templ/cmd/templ@latest

# copy sourcecode into the working directory
COPY . .

# provide port 3000 for access to the app
EXPOSE 3000

# run air as defined here
# https://github.com/air-verse/air?tab=readme-ov-file#installation-and-usage-for-docker-users-who-dont-want-to-use-air-image
CMD [ "air", "-c", ".air.toml" ]