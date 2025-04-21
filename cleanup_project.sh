# remove all files that are generated
sh ./app/.vscode/cleanup_container.sh
sh ./db/.vscode/cleanup_container.sh
cd remote
sh ./cleanup_deploy.sh
