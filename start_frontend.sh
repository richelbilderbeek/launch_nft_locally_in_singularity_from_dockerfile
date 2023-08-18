#!/bin/bash
#
# Start the frontend
#
# Usage:
#
#   ./start_frontend.sh
#

is_running=$(bash is_backend_running.sh)
if [[ ${is_running} == "1" ]]
then
  echo "Backend is running. Continuing"
else
  echo "ERROR: Backend is not running"
  echo " "
  echo "Tip: run ./start_backend.sh"
  exit 1
fi

# Check for latest version
if [ ! -d "../nextflow_troubleshooting" ]
then
  echo "ERROR: cannot find folder '../nextflow_troubleshooting'"
  echo " "
  echo "Tip: Run:"
  echo " "
  echo "cd .."
  echo "git clone https://github.com/richelbilderbeek/nextflow_troubleshooting"
fi

(
  cd ../nextflow_troubleshooting || exit 42
  script_filename="scripts/update_singularity.sh"
  if [ ! -f "${script_filename}" ]
  then
    echo "ERROR: ${script_filename} not found."
    exit 42
  fi
  bash "${script_filename}"
)

if [ $(bash is_ssh_server_running.sh) -eq "0" ]
then
  echo "ERROR: ssh server is not running"
  echo " "
  echo "Tip: run:"
  echo " "
  echo "sudo apt install openssh-server"
  exit 42
fi

#(
#  cd frontend || exit 42
#  ./download_nginx_conf.sh
#)

(
  cd frontend || exit 42
  ./download_proxy_config_json.sh
)

(
  cd frontend || exit 42
  ./nf-tower_web-latest.sif
)
