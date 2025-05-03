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
sh -c "su - postgres -c 'postgres -D \"$PGDATA\" &'"

# Keep the container running
# tail = Linux command that outputs the end of a file
# -f = This option tells tail to "follow" the file, 
#      meaning it will wait for new lines to be added and never exit.
# /dev/null = This is a special file that discards all data written to it and 
#      returns nothing when read from. It's like a black hole.
exec tail -f /dev/null