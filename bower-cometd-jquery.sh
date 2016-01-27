#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
POM_DIR="$DIR/.."

if [ "$BOWER_COMETD_REPO_FOLDER" == "" ]
then
    REPO="$DIR/bower-cometd-jquery"
fi

cd $REPO
git rm -rf * || echo

cd $POM_DIR/cometd-javascript/jquery/target/cometd-javascript-jquery-*
JS_DIR=`pwd`

cd $REPO
mkdir -p $REPO/jquery
cp -R $JS_DIR/jquery/jquery.cometd*.js $REPO/jquery
cp $DIR/bower-cometd-jquery.json $REPO/bower.json

git add .

VERSION=`grep "<version>" $POM_DIR/pom.xml | head -n 1 | tr -d '[[:space:]]' | sed 's|<version>||g' | sed 's|</version>||g'`

if [[ $VERSION == *"SNAPSHOT"* ]]
then
    echo Snapshot version. Exiting
    exit
fi

git commit -m"Releasing $VERSION" || (echo Already up to date; exit 1)
git tag $VERSION
git push origin master --tags
