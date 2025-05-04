# start postgres and ensure the database is initialized
sh -c "/db/.vscode/init_container.sh true"

# Keep the container running
# tail = Linux command that outputs the end of a file
# -f = This option tells tail to "follow" the file, 
#      meaning it will wait for new lines to be added and never exit.
# /dev/null = This is a special file that discards all data written to it and 
#      returns nothing when read from. It's like a black hole.
exec tail -f /dev/null