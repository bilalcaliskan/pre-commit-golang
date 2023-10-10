#!/usr/bin/env bash

# get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source shared.sh using the determined directory
source "$DIR/shared.sh"

# start vendoring process
go mod tidy $@ || fail "tidy"

git diff --exit-code go.* &> /dev/null
if [ $? -ne 0 ]; then
    echo "go.mod or go.sum differs, please re-add it to your commit"
    exit 3
fi
