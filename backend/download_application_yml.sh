#!/bin/bash
#
# Download the Seqera example application.yml file.
#
# Usage:
#
#   ./download_application_yml.sh
#

filename="application.yml"

if [[ -f ${filename} ]]
then
  echo "NFT configuration file '${filename}' already present."
else
  echo "NFT configuration file '${filename}' absent. Downloading it now."
  wget https://github.com/seqeralabs/nf-tower/raw/master/tower-backend/src/main/resources/application.yml

  # Confirm it works
  if [[ -f ${filename} ]]
  then
    echo "Success: NFT configuration file '${filename}' is now present."
  else
    echo "ERROR: NFT configuration file '${filename}' is still absent...?"
  fi
fi

