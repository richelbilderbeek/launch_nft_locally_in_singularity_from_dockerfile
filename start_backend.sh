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

    

    export TOWER_SMTP_USER="richel"
    export TOWER_SMTP_PASSWORD="iloverichel"

    # singularity run --fakeroot --net --network=none --hostname=backend nf-tower_backend-latest.sif &
    # singularity run --fakeroot --net --hostname=backend nf-tower_backend-latest.sif &

    # singularity run nf-tower_backend-latest.sif &

    # New attempt by with MD
    #singularity run --net --network=none --hostname=backend nf-tower_backend-latest.sif &

    # Still fails, gives output: 
    #
    # Server Running: http://localhost:8080
    singularity run --hostname=backend nf-tower_backend-latest.sif &

    # FATAL:   container creation failed: dns ip backend:8080 is not a valid IP address
    # singularity run --dns backend:8080 nf-tower_backend-latest.sif &

    # FATAL:   container creation failed: dns ip backend is not a valid IP address
    # singularity run --dns backend nf-tower_backend-latest.sif &

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
  echo "Warning: backend is still not running...?"
  echo "Ignoring :-)"

  # GHA is slower
  #if [[ -z "${GITHUB_ACTIONS}" ]]
  #then
  #  exit 1
  #fi
fi
