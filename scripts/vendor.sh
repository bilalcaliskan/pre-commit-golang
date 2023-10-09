#!/usr/bin/env bash

source shared.sh

go mod vendor || fail "vendoring"
