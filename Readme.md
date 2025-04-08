# docker_dev-container

This repository is for learing porposes.<br/>
It's a minimal out of the box docker sample.<br/>

Files:<br/>
Dockerfile: describes docker instructions<br/>
docker-compose.yaml: Describes startup of container<br/>
main.go: serverside application (simple http server)<br/>

1. Run init_project.sh first:<br/>
This file genrates the necessary files go.mod and go.sum. <br/>

2. Run the docker devcontainer:<br/>
(Ctrl + Shift + P) --> Dev Containers: Rebuild and Reopen in Container. <br/>

3. Run air to generate executeable and the server: <br/>
Terminal --> air

Run the application without container:<br/>
docker compose up<br/>

Description:<br/>
Uses the docker-compose.yaml file to start one or multiple containers
Add -d to the command to run in detached mode

Visit the application:<br/>
http://localhost:8080 <br/>