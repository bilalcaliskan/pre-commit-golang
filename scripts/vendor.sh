#!/usr/bin/env bash

# get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source shared.sh using the determined directory
source "$DIR/shared.sh"

# start vendoring process
go mod vendor $@ || fail "vendoring"

git diff --exit-code vendor &> /dev/null
if [ $? -eq 1 ]; then
    echo "vendor dir differs, please re-add it to your commit"
    exit 1
fi
