# grant rights to user
psql -U ${POSTGRES_USER} -c "GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} to ${DB_CLIENT_USER};"

# init database tables
psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} -a -f "/db/config/02_init_tables.sql"

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Failed to initialize Database ${POSTGRES_DB} with tables."
else
    echo "Database ${POSTGRES_DB} initialized with tables successfully."
fi