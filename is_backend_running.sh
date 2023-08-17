#!/bin/bash
#
# Determine if the backend is running
#
# Usage:
#
#   ./is_backend_running.sh
#   ./is_backend_running.sh --verbose
#

if [ "$#" -ne 0 ]
then 
  ss -natu | grep 8080
fi

# Port may be shutting down, gives TIME-WAIT instead of LISTEN
if ss -natu | grep "tcp[[:space:]]*LISTEN[[:space:]]*0[[:space:]]*4096[[:space:]]*.*8080" >/dev/null
then
  echo "1"
else
  echo "0"
fi