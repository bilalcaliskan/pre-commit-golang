#!/usr/bin/env bash

set -e -o pipefail

# get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# source shared.sh using the determined directory
source "$DIR/shared.sh"

if ! binary_exists "gofmt"; then
    echo "gofmt is not installed or not available in the PATH" >&2
    exit 2
fi

# initialize ARGS with any provided arguments that don't end in .go
ARGS=""

files=()
for arg in "$@"; do
    if [[ $arg != *.go ]]; then
        ARGS="$ARGS $arg"
    else
        files+=("$arg")
    fi
done

# if there are any .go files, run gofmt
if [[ ${#files[@]} -ne 0 ]]; then
    files_str="${files[*]}"
    echo "running gofmt for files: $files_str"
    output="$(gofmt -l -w $ARGS $files_str)"
    if [[ -n "$output" ]]; then
        echo "The following files were reformatted:"
        echo "$output"
        exit 1
    fi
else
    echo "no .go files found in arguments"
    exit 3
fi
