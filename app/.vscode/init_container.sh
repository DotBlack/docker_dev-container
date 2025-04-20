# generate all go files based on templ files

# executes the tasks performed to initialize the container
# -watch true = This flag activates the watch mode. Instead of performing 
# a one-time generation and exiting, templ will stay running in 
# the background and monitor the specified files or directories for changes.
# After changing a templ file it will be automatically regenerated.
templ generate -watch true