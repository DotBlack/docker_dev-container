# get the dstIP to deploy to
dstIP=""
read -p "Enter IP-Adress to deploy to via SFTP: " dstIP
dstUsr=""
read -p "Enter Remote SSH username: " dstUsr
# Export the latest image
docker save -o $HOME/Desktop/DEV/docker_dev-container/remote/docker_dev-container-app.tar \
    docker_dev-container-app docker_dev-container-app:latest

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
put \"$current_path\"/docker_dev-container-app.tar
put \"$current_path\"/docker-compose_local.yaml
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
docker container stop docker_dev-container
docker container remove docker_dev-container
docker image remove docker_dev-container-app
docker image load -i docker_dev-container-app.tar
docker compose -f docker-compose_local.yaml up -d
exit'
# Notify the user that the deployment is finished
echo "Deployment finished!"