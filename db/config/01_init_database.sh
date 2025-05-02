# The database itselfe is will be created with the database startup as defined in docker-compose.yaml
# POSTGRES_DB: This variable specifies the name of the database that will be created 
# as part of the PostgreSQL server startup. In this case, it is set to db.

# init database tables
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -a -f "/db/config/02_init_tables.sql"

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Failed to initialize Database ${POSTGRES_DB} with tables."
else
    echo "Database ${POSTGRES_DB} initialized with tables successfully."
fi

# Copy the prepared config file into the data directory
cp /db/config/postgresql.conf /db/data/postgresql.conf

# TODO: edit port after startup for psql database in postgresql.conf
# afterwards restart database service
# check if possible with compose file