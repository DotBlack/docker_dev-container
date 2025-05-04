# Export the latest image
docker build -f "../app/Dockerfile-app" --target prd -t application-app-prd ../app
docker build -f "../db/Dockerfile-db" --target prd -t application-db-prd ../db
docker save -o $HOME/Desktop/DEV/docker_dev-container/remote/application-app-prd.tar \
    application-app-prd application-app-prd:latest
docker save -o $HOME/Desktop/DEV/docker_dev-container/remote/application-db-prd.tar \
    application-db-prd application-db-prd:latest
# first import the images
docker image load -i application-app-prd.tar
docker image load -i application-db-prd.tar

# create data folder
mkdir db
mkdir db/data

# run the application
docker compose -f docker-compose_prd.yaml --env-file ../.env up -d