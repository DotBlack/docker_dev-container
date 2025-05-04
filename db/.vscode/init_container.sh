# Find path for postgres
postgresPath=$(dirname "$(find /usr -name initdb 2>/dev/null)")
echo $postgresPath

# check if data folder exists
if [ -d $PGDATA ]; then
  echo "Data folder exists."
else
  echo "Data folder does not exist."
  mkdir $PGDATA
  echo "Data folder created."
fi

# change ownership of mount to user=postgres:group=postgres
chown -R postgres:postgres $PGDATA
# ensure the correct rights on the drive (rwx)
chmod 700 $PGDATA

# check if data folder is empty
if [ -z "$(ls -A "$PGDATA")" ]; then
  # initialize the database when the folder is empty
  echo "Initializing the database now..."
    if sh -c "su - postgres -c '$postgresPath/initdb -D \"$PGDATA\"'"; then
      echo "initdb completed successfully."
    else
      echo "initdb failed!" >&2
      exit 1
    fi
else
  echo "Database already initialized..."
fi

# copy prepared config files from config to data
cp /db/config/postgresql.conf /db/data/postgresql.conf
cp /db/config/pg_hba.conf /db/data/pg_hba.conf
# start the database
echo "Starting PostgreSQL in background for setup..."
sh -c "su - postgres -c '$postgresPath/pg_ctl -D \"$PGDATA\" start'"

# Wait until the database is ready
until pg_isready -h "$HOST" -p "$PORT" -d "$POSTGRES_DB" -U "$POSTGRES_USER" 2>/dev/null; do
  echo "Waiting for PostgreSQL to be ready..."
  # Recheck each 5 seconds state of database if ready
  sleep 5 
done
echo "PostgreSQL is up and running!"

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

# stop the database
echo "Stopping PostgreSQL in background used for setup..."
sh -c "su - postgres -c '$postgresPath/pg_ctl -D \"$PGDATA\" stop'"

echo "Starting the database for usage..."
exec su - postgres -c "$postgresPath/postgres -D $PGDATA -c config_file=$PGDATA/postgresql.conf"