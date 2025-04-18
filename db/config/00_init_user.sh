# connect to postgres container via shell
docker exec -it postgres /bin/bash
# login to database
POSTGRES="psql -U ${POSTGRES_USER} ${POSTGRES_DB}"

# create database client role
echo "Creating database role: ${DB_CLIENT_USER}"
$POSTGRES <<-EOSQL
CREATE USER ${DB_CLIENT_USER} WITH PASSWORD '${DB_CLIENT_PASSWORD}';
EOSQL
echo "database role: ${DB_CLIENT_USER} created"