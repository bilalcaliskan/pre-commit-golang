#!/usr/bin/env bash

fail() {
  echo "$1 failed"
  exit 1
}

# Fetch the module path from go.mod
MODULE_PATH=$(grep module go.mod | awk '{print $2}')

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
        echo "Running tests for package: $pkg"
        full_pkg_path="$MODULE_PATH/$pkg"
        go test -short $ARGS "$full_pkg_path" || fail "unit tests"
    done
else
    echo "No .go files found in arguments."
fi
