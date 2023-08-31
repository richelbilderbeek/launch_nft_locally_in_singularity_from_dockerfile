#!/bin/bash
#
# Stop the backend
#
# Usage:
#
#   ./stop_backend.sh
#

is_running=$(bash is_backend_running.sh)
if [[ ${is_running} == "1" ]]
then
  echo "Backend is running. Continuing"
else
  echo "WARNING: Backend is not running, hence I cannot stop it"
  echo " "
  echo "Tip: run ./start_backend.sh"
  echo " "
  echo "Proceeding anyways :-)"
fi

if [ "$#" -ne 0 ]
then 
  # From https://superuser.com/a/42849
  lsof -i tcp:8080
fi




# (base) richel@richel-latitude-7430:~/GitHubs/nbis_data_experiment_private/build_nft_from_docker$ lsof -i tcp:8080
# COMMAND   PID   USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
# java    28031 richel  323u  IPv6 458774      0t0  TCP *:http-alt (LISTEN)
pid=$(lsof -i tcp:8080 | tail -n 1 | grep -E "java[[:space:]]+(.*)[[:space:]]+$USER" | awk '{print $2}')
kill "${pid}"

echo "Waiting a bit..."
sleep 10

is_running=$(bash is_backend_running.sh)
if [[ ${is_running} == "1" ]]
then
  echo "ERROR: backend is still running...?"
  exit 1
else
  echo "Success: Backend is not running anymore. Yay :-)"
  exit 0
fi
