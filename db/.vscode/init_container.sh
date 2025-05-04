# check if data folder exists
if [ -d $PGDATA ]; then
  echo "Data folder exists."
else
  echo "Data folder does not exist."
  mkdir /db/data
  echo "Data folder created."
fi

# Wait until the database is ready
until pg_isready -h "$HOST" -p "$PORT" -d "$POSTGRES_DB" -U "$POSTGRES_USER" 2>/dev/null; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 5 # Adjust sleep interval as needed
done
echo "PostgreSQL is up and running!"

# copy prepared config files from config to data
cp /db/config/postgresql.conf /db/data/postgresql.conf
cp /db/config/pg_hba.conf /db/data/pg_hba.conf
# signal postgres to reload the config file
sh -c "su - postgres -c 'pg_ctl reload -D \"/$PGDATA\"'"

# setup database
# The existence of DB_CLIENT_USER is taken as indicatior if the database was already set up
if psql -U "${POSTGRES_USER}" -c "SELECT 1 FROM pg_roles WHERE rolname='${DB_CLIENT_USER}'" | grep -q 1; then
    echo "Nothing to be done - Database already setup!"
else
    echo "Database gonna be setup now!"
    echo "Setup database users..."
    sh /db/config/00_init_user.sh
    echo "Setup database datastructure..."
    sh /db/config/01_init_database.sh
fi