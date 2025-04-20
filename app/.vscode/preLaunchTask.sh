##### PRELAUNCH - TASK 1 #####

# Stopping the currently running app process needed.
# Air autostarts the application when lanching the container.
# Stop it before launching a new instance with the delve debugger.

# pkill = process kill
# -9 = SIGKILL sent to all processes corresponding to given one
# -e = run pkill only on processes exactly matching the given name
# -f = full command line search with arguments
# /app/main = app to kill


# check if app is running named /app/main
if pgrep -e -f /app/main; then 
    # run pkill on the app to stop it
    pkill -9 -e -f /app/main
    # echo a message to inform the user that the app was stopped
    echo 'Matching process was stopped.'
else 
    # echo a message to inform the user that no app was stopped
    echo 'No matching process found.'
fi


##### PRELAUNCH - TASK 2 #####

# build the application with debug flags
# -N = Disables optimizations
# -l = Disables inlining
go build -gcflags="-N -l" -o main *.go