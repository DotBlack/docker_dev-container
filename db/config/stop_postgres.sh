# stop postgres instance
sh -c "su - postgres -c 'pg_ctl stop -D \"$PGDATA\"'"