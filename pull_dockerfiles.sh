#!/bin/bash
#
# Pulls the NF tower dockerfile
#
# Usage:
#
#   ./pull_dockerfile.sh
#
# If one gets the error:
#
#   Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
# 
# Do (from https://askubuntu.com/a/739861):
#
#   sudo usermod -aG docker $USER
#   Restart computer (logout and login does not work)
#
#
# Do (from https://askubuntu.com/a/477554):
#
#   sudo groupadd docker
#   sudo gpasswd -a $USER docker
#   newgrp docker
#   Restart computer (logout and login does not work)
#

image_name="misialq/nf-tower:backend-latest"
if [[ $(docker images -q ${image_name}) ]]
then
  echo "docker image '${image_name}' already present."
else
  echo "docker image '${image_name}' absent. Pulling it now."
  docker pull ${image_name}

  # Confirm it works
  if [[ $(docker images -q ${image_name}) ]]
  then
    echo "Succes: docker image '${image_name}' is now present."
  else
    echo "ERROR! docker image '${image_name}' is still absent...?"
    exit 42
  fi
fi



image_name="misialq/nf-tower:web-latest"
if [[ $(docker images -q ${image_name}) ]]
then
  echo "docker image '${image_name}' already present."
else
  echo "docker image '${image_name}' absent. Pulling it now."
  docker pull ${image_name}

  # Confirm it works
  if [[ $(docker images -q ${image_name}) ]]
  then
    echo "Succes: docker image '${image_name}' is now present."
  else
    echo "ERROR! docker image '${image_name}' is still absent...?"
    exit 42
  fi
fi


# $ docker image ls
#
# REPOSITORY                      TAG                     IMAGE ID       CREATED         SIZE
# misialq/nf-tower                backend-latest          1505f63fc6a0   4 months ago    641MB
# misialq/nf-tower                web-latest              d08d9b237573   4 months ago    36.3MB
