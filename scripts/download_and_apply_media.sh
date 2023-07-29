#!/bin/bash
set -e

remote_user="root"
remote_host="142.132.176.205"
remote_file_path="~/pyapps/tmp/media/portfolio/media"
local_destination="./media"

# Download the file using scp
echo "Downloading database from remote..."
scp "${remote_user}@${remote_host}:${remote_file_path}" "${local_destination}"