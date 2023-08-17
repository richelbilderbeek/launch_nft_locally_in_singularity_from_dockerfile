#!/bin/bash
#
# Creates two Singularity containers for NFT.
#
# Usage:
#
#   ./create_singularity_containers.sh
#

docker_image_name="misialq/nf-tower:backend-latest"
singularity_filename="backend/nf-tower_backend-latest.sif"

if [[ -f ${singularity_filename} ]]
then
  echo "Singularity image file '${singularity_filename}' already present."
else
  echo "Singularity image file '${singularity_filename}' absent. Pulling it now."
  singularity pull "docker://${docker_image_name}"

  # Confirm it works
  if [[ -f ${singularity_filename} ]]
  then
    echo "Success: Singularity image file '${singularity_filename}' is now present."
  else
    echo "ERROR: Singularity image file '${singularity_filename}' is still absent...?"
  fi
fi

docker_image_name="misialq/nf-tower:web-latest"
singularity_filename="frontend/nf-tower_web-latest.sif"

if [[ -f ${singularity_filename} ]]
then
  echo "Singularity image file '${singularity_filename}' already present."
else
  echo "Singularity image file '${singularity_filename}' absent. Pulling it now."
  singularity pull "docker://${docker_image_name}"
  exit 42

  # Confirm it works
  if [[ -f ${singularity_filename} ]]
  then
    echo "Success: Singularity image file '${singularity_filename}' is now present."
  else
    echo "ERROR: Singularity image file '${singularity_filename}' is still absent...?"
  fi
fi
