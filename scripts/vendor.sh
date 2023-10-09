#!/bin/bash

fail() {
  echo "$1 failed"
  exit 1
}

go mod vendor || fail "vendoring"
