#!/bin/bash
#
# Download the NGINX example confix file.
#
# Usage:
#
#   ./download_nginx_conf.sh
#

filename="nginx.conf"
if [[ -f ${filename} ]]
then
  echo "NGINX configuration file '${filename}' already present."
else
  echo "NGINX configuration file '${filename}' absent. Downloading it now."
  wget "https://raw.githubusercontent.com/seqeralabs/nf-tower/master/tower-web/${filename}"

  # Confirm it works
  if [[ -f ${filename} ]]
  then
    echo "Success: NGINX configuration file '${filename}' is now present."
  else
    echo "ERROR: NGINX configuration file '${filename}' is still absent...?"
  fi
fi