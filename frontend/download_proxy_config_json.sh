#!/bin/bash
#
# Download the NGINX example confix file.
#
# Usage:
#
#   ./download_proxy_config_json.sh
#

filename="proxy.config.json"
if [[ -f ${filename} ]]
then
  echo "NGINX development configuration file '${filename}' already present."
else
  echo "NGINX development configuration file '${filename}' absent. Downloading it now."
  wget "https://raw.githubusercontent.com/seqeralabs/nf-tower/master/tower-web/${filename}"

  # Confirm it works
  if [[ -f ${filename} ]]
  then
    echo "Success: NGINX development configuration file '${filename}' is now present."
  else
    echo "ERROR: NGINX development configuration file '${filename}' is still absent...?"
  fi
fi
