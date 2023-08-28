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
    singularity run --hostname=backend nf-tower_backend-latest.sif &
  )
fi

echo "Waiting until backend is ready..."
sleep 10

is_running=$(bash is_backend_running.sh)
if [[ ${is_running} == "1" ]]
then
  echo "Success: backend is now running. Yay :-)"
  exit 0
else
  echo "ERROR: backend is still not running...?"

  # GHA is slower
  if [[ -z "${GITHUB_ACTIONS}" ]]
  then
    exit 1
  fi
fi
