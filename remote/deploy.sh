# get the dstIP to deploy to
dstIP=""
read -p "Enter IP-Adress to deploy to via SFTP: " dstIP
dstUsr=""
read -p "Enter Remote SSH username: " dstUsr
# Export the latest image
docker build -f "../app/Dockerfile-app" --target prd -t application-app-prd ../app
docker build -f "../db/Dockerfile-db" --target prd -t application-db-prd ../db
docker save -o $HOME/Desktop/DEV/docker_dev-container/remote/application-app-prd.tar \
    application-app-prd application-app-prd:latest
docker save -o $HOME/Desktop/DEV/docker_dev-container/remote/application-db-prd.tar \
    application-db-prd application-db-prd:latest

# start a SSH session to delete the folder
ssh ${dstUsr}@${dstIP} \
'cd ../home/
rm -r docker_dev-container
exit'

# string of SFTP commands to perform
current_path=$(pwd)
sftp="
cd ../home/
mkdir docker_dev-container
cd docker_dev-container
mkdir db
put \"$current_path\"/application-app-prd.tar
put \"$current_path\"/application-db-prd.tar
put \"$current_path\"/docker-compose_prd.yaml
put \"$current_path\"/../Readme.md
exit"
# create temp file
temp_sftp_file=$(mktemp "/tmp/temp_sftp_file.XXXX")
echo "$sftp" > "$temp_sftp_file"
# this command performs the upload of the whole project to the remote server
sftp -b "$temp_sftp_file" root@${dstIP}
# remove temp file
rm "$temp_sftp_file"

# start a SSH session to redeploy the running container
# 1. stop running container
# 2. remove the stopped container
# 3. remove the old image
# 4. load the new image
# 5. start the image as container composition
ssh ${dstUsr}@${dstIP} \
'cd ../home/docker_dev-container
docker container stop app
docker container stop postgres
docker container remove app
docker container remove postgres
docker image remove application-app-prd
docker image remove application-db-prd
docker image load -i application-app-prd.tar
docker image load -i application-db-prd.tar
docker compose -f docker-compose_prd.yaml up -d
exit'
# Notify the user that the deployment is finished
echo "Deployment finished!"