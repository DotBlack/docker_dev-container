db=$(cat << 'EOF'
if psql -U "${POSTGRES_USER}" -c "SELECT 1 FROM pg_roles WHERE rolname='${DB_CLIENT_USER}'" | grep -q 1; then
    echo "Found user \"${DB_CLIENT_USER}\". Database already initialized!"
else
    echo "User \"${DB_CLIENT_USER}\" not found. Database gonna be initialized now!"
    sh ./config/00_init_user.sh
    sh ./config/01_init_database.sh
fi
EOF
)

# create tmp folder if missing
if [ ! -d "/tmp" ]; then
    mkdir tmp
fi

# create temp file
temp_db_file=$(mktemp "/tmp/temp_db_file.XXXX")
echo "$db" > "$temp_db_file"
# SSH into running container
docker exec -it postgres /bin/bash -c "$db"
# remove temp file
rm "$temp_db_file"