# RUN this file from path: /db
# ./.vscode/init_container.sh

# Wait until the database is ready
until pg_isready -h "$HOST" -p "$PORT" -d "$POSTGRES_DB" -U "$POSTGRES_USER" 2>/dev/null; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 5 # Adjust sleep interval as needed
done
echo "PostgreSQL is up and running!"

# check if the database user exists
# existing databse user means, the database was already initialized
if psql -U "${POSTGRES_USER}" -c "SELECT 1 FROM pg_roles WHERE rolname='${DB_CLIENT_USER}'" | grep -q 1; then
    echo "Nothing to be done - Database already initialized!"
else
    echo "Database gonna be initialized now!"
    sh /db/config/00_init_user.sh
    sh /db/config/01_init_database.sh
fi