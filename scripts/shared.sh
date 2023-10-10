#!/usr/bin/env bash

# Fetch the module path from go.mod
MODULE_PATH=$(grep module go.mod | awk '{print $2}')

fail() {
  echo "$1"
  exit 1
}

binary_exists() {
  echo "binary name is $1, checking if it exists on the system..."
  if ! command -v "$1" &> /dev/null ; then
    # binary does not exists
    return 1
  fi

  # binary exists
  return 0
}
