#!/usr/bin/env bash

set -e
set -x

cd cometd
mvn clean package -DskipTests

