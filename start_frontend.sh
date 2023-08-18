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

(
  cd frontend || exit 42
  ./download_nginx_conf.sh
)

(
  cd frontend || exit 42
  ./download_proxy_config_json.sh
)

(
  cd frontend || exit 42
  ./nf-tower_web-latest.sif
)
