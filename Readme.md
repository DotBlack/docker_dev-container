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
When the container runs, the app can be accessed.

Visit the application:<br/>
http://localhost:8080 <br/>

3. The application can be updated by following actions: <br/>
    - Run "templ generate" in the terminal <br/>
    - Edit and save any go file <br/>
--> The application will be rebuilt and can be visited by the link above. <br/>

Optional: <br/>
Run the application without container:<br/>
docker compose -f docker-compose_local.yaml up<br/>

Description:<br/>
Uses the docker-compose_local.yaml file to start one or multiple containers without dev-container.<br/>
Add -d to the command to run in detached mode <br/>

