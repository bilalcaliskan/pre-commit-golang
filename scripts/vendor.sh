#!/usr/bin/env bash

source scripts/shared.sh

go mod vendor || fail "vendoring"
