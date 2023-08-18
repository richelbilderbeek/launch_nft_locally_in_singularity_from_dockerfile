#!/bin/bash
#
# Determine if an SSH server is running.
#
# Usage:
#
#   ./is_ssh_server_running.sh
#   ./is_ssh_server_running.sh -V
#   ./is_ssh_server_running.sh --verbose
#
# Output:
#
#   * Prints 0 and has return code 0 with there is no SSH server running
#   * Prints 1 and has return code 1 with there is an SSH server running
#   * In verbose mode, prints more
#

verbose=$(("$#" != 0))

if [ "${verbose}" -eq 1 ]
then
  echo "Verbose mode"
fi

if [ -n "$(which sshd)" ]
then
  if [ "${verbose}" -eq 1 ]; then echo "sshd is present"; fi
  echo "1"
  exit 1
else
  if [ "${verbose}" -eq 1 ]
  then
    echo "sshd is not present"
    echo " "
    echo "Tip: run:"
    echo " "
    echo "sudo apt install openssh-server"
  fi
  echo "0"
  exit 0
fi

