#!/usr/bin/env bash

# Fetch the module path from go.mod
MODULE_PATH=$(grep module go.mod | awk '{print $2}')

fail() {
  echo "$1"
  exit 1
}
