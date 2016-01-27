#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$REPO" == "" ]
then
    REPO="$DIR/bower-cometd"
fi

if [ "$POM_DIR" == "" ]
then
    POM_DIR="$DIR/../cometd"
fi

cd $REPO
git rm -rf * || echo

cd $POM_DIR/cometd-javascript/common/target/cometd-javascript-common-*
JS_DIR=`pwd`

cd $REPO
cp -R $JS_DIR/org* $REPO
cp $DIR/bower-cometd.json $REPO/bower.json
cp $DIR/README-bower-cometd.md $REPO/README.md

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
