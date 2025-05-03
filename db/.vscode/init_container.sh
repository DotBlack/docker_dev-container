# check if data folder exists
if [ -d /db/data ]; then
  echo "Data folder exists."
else
  echo "Data folder does not exist."
  mkdir /db/data
  echo "Data folder created."
fi

# check if any content is stored in data folder
if [ -z "$(ls -A /db/data)" ]; then
  echo "Data folder is empty"
  echo "Database is gonna be initialized now."
  # Initialize the database
  su - postgres -c "initdb -D /db/data"
  # Copy the prepared config file into the data directory
  echo "Replacing default postgres configuration file with prepared file."
  cp /db/config/postgresql.conf /db/data/postgresql.conf
  cp /db/config/pg_hba.conf /db/data/pg_hba.conf
else
  echo "Data folder is NOT empty."
  echo "Database is already initialized! ... nothing to do."
fi

# check if data folder exists
if [ -d /run/postgresql ]; then
  echo "Postgresql run folder exists."
else
  echo "Postgresql run folder does not exist."
  # create required path
  mkdir -p /run/postgresql
  # set rights for user postgres
  chown postgres:postgres /run/postgresql
  echo "Postgresql run folder created."
fi

# start postgres as new shell instance
sh -c "su - postgres -c 'postgres -D /db/data &'"

# Wait until the database is ready
until pg_isready -h "$HOST" -p "$PORT" -d "$POSTGRES_DB" -U "$POSTGRES_USER" 2>/dev/null; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 5 # Adjust sleep interval as needed
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