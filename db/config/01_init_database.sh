# database name
db_name="dev_container"

# create database
psql -U ${POSTGRES_USER} -c "CREATE DATABASE \"${db_name}\" OWNER \"${DB_CLIENT_USER}\";"

# init database tables
psql -U ${POSTGRES_USER} -d ${db_name} -a -f "02_init_tables.sql"