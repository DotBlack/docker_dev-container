# create database client role
psql -U ${POSTGRES_USER} -c "CREATE USER ${DB_CLIENT_USER} WITH PASSWORD '${DB_CLIENT_PASSWORD}';"

# Check for errors
if [ $? -ne 0 ]; then
    echo "Error: Failed to create user ${DB_CLIENT_USER}."
else
    echo "User ${DB_CLIENT_USER} created successfully."
fi