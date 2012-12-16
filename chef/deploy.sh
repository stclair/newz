#!/bin/bash

# Usage: ./deploy.sh [host]

host="${1}"

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null

rsync -r ../project $host:/home/ubuntu/www

tar cj . | ssh -o 'StrictHostKeyChecking no' "$host" '
sudo rm -rf ~/chef &&
mkdir ~/chef &&
cd ~/chef &&
tar xj &&
sudo bash install.sh

rm -r /home/ubuntu/www/madisonian
mv /home/ubuntu/www/project /home/ubuntu/www/madisonian
'