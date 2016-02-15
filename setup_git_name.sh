#!/usr/bin/env bash

set -e
set -x

function setup_git_name {
    FOLDER=$1
    EMAIL=$2
    NAME=$3

    cd $FOLDER
    git config user.email "$EMAIL"
    git config user.name "$NAME"
    cd -
}

setup_git_name "bower-cometd" "federico@fissore.org" "Federico Fissore"
setup_git_name "bower-cometd-jquery" "federico@fissore.org" "Federico Fissore"
setup_git_name "bower-cometd-dojo" "federico@fissore.org" "Federico Fissore"

