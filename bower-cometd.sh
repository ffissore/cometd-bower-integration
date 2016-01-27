#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
POM_DIR="$DIR/.."

if [ "$BOWER_COMETD_REPO_FOLDER" == "" ]
then
    REPO="$DIR/bower-cometd"
fi

cd $REPO
git rm -rf * || echo

cd $POM_DIR/cometd-javascript/common/target/cometd-javascript-common-*
JS_DIR=`pwd`

cd $REPO
cp -R $JS_DIR/org* $REPO
cp $DIR/bower-cometd.json $REPO/bower.json

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
