#!/usr/bin/env bash

# get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source shared.sh using the determined directory
source "$DIR/shared.sh"

# initialize ARGS with any provided arguments that don't end in .go
ARGS=""
declare -A packages
for arg in "$@"; do
    if [[ $arg != *.go ]]; then
        ARGS="$ARGS $arg"
    else
        pkg=$(dirname "$arg")
        packages["$pkg"]=1
    fi
done

# if there are any .go files, run tests for their respective packages
if [[ ${#packages[@]} -ne 0 ]]; then
    for pkg in "${!packages[@]}"; do
        echo "running tests for package: $pkg"
        full_pkg_path="$MODULE_PATH/$pkg"
        go test -short $ARGS "$full_pkg_path" || fail "unit tests"
    done
else
    echo "no .go files found in arguments"
fi
