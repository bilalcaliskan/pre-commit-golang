#!/bin/bash

fail() {
  echo "unit tests failed"
  exit 1
}

FILES=$(go list ./... | grep -v /vendor/) || fail

# Another way to display arguments
go test -short -v $@ ${FILES} || fail
