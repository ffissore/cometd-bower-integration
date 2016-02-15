#!/usr/bin/env bash

set -e
set -x

function clone_or_fetch {
    FOLDER=$1
    REPO=$2

    if [ -d $FOLDER ]
    then
        cd $FOLDER
        git fetch --all
        cd -
    else
        git clone $REPO
    fi
}

clone_or_fetch "cometd" https://github.com/cometd/cometd.git

cd cometd
git checkout $COMETD_TAG
cd -

clone_or_fetch "bower-cometd" https://github.com/ffissore/bower-cometd.git
clone_or_fetch "bower-cometd-jquery" https://github.com/ffissore/bower-cometd-jquery.git
clone_or_fetch "bower-cometd-dojo" https://github.com/ffissore/bower-cometd-dojo.git

