#!/bin/bash

fail() {
  echo "vendoring failed"
  exit 1
}

go mod vendor $@ || fail

