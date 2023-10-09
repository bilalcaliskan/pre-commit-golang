#!/usr/bin/env bash

# get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source shared.sh using the determined directory
source "$DIR/shared.sh"

# start vendoring process
go mod vendor || fail "vendoring"
