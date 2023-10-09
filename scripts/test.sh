#!/usr/bin/env bash

source scripts/shared.sh

# Initialize ARGS with any provided arguments that don't end in .go
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

# If there are any .go files, run tests for their respective packages
if [[ ${#packages[@]} -ne 0 ]]; then
    for pkg in "${!packages[@]}"; do
        echo "running tests for package: $pkg"
        full_pkg_path="$MODULE_PATH/$pkg"
        go test -short $ARGS "$full_pkg_path" || fail "unit tests"
    done
else
    echo "no .go files found in arguments"
fi
