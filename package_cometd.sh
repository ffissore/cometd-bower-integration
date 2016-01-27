#!/usr/bin/env bash

set -e

cd cometd
mvn clean package -DskipTests
