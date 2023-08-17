#!/bin/bash
#
# Start the backend
#
# Usage:
#
#   ./start_backend.sh
#

is_running=$(bash is_backend_running.sh)
if [[ ${is_running} == "1" ]]
then
  echo "Backend is already running. Doing nothing :-)"
  exit 0
else
  echo "Backend is not running, starting it"
  (
    cd backend || exit 42
    ./nf-tower_backend-latest.sif &
  )
fi

echo "Waiting until backend is ready..."
sleep 10

if [[ ${is_running} == "1" ]]
then
  echo "Success: backend is now running. Yay :-)"
  exit 0
else
  echo "ERROR: backend is still not running...?"
  exit 1
fi