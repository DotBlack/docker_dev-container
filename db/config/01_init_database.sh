# create database
psql -U ${POSTGRES_USER} -c "CREATE DATABASE \"${POSTGRES_DB}\" OWNER \"${DB_CLIENT_USER}\";"

# init database tables
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -a -f "02_init_tables.sql"