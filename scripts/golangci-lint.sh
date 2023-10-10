#!/usr/bin/env bash

# get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source shared.sh using the determined directory
source "$DIR/shared.sh"

if binary_exists "golangci-lint"; then
    exec golangci-lint run "$@"
else
    echo "golangci-lint not installed or available in the PATH" >&2
    echo "please check https://github.com/golangci/golangci-lint" >&2
    exit 2
fi
