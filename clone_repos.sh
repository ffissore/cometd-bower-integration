#!/usr/bin/env bash

set -e
git clone https://github.com/cometd/cometd.git
cd cometd
git checkout $COMETD_TAG
cd -
git clone https://github.com/ffissore/bower-cometd.git
git clone https://github.com/ffissore/bower-cometd-jquery.git
