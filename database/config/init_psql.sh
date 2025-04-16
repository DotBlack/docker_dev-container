# https://hub.docker.com/r/alpine/psql

# pull latest docker container for alpine
docker pull alpine/psql
# https://hub.docker.com/_/postgres
# run docker container
$ docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -d postgres
