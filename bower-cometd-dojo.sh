#!/usr/bin/env bash

set -e
set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

POM_DIR="$DIR/cometd"
REPO="$DIR/bower-cometd-dojo"

cd $REPO
git rm -rf * || echo

cd $POM_DIR/cometd-javascript/dojo/target/cometd-javascript-dojo-*
JS_DIR=`pwd`

cd $REPO
mkdir -p $REPO/cometd
cp -R $JS_DIR/dojox/cometd.js $REPO/
cp -R $JS_DIR/dojox/cometd/*.js $REPO/cometd
rm -f $REPO/cometd/main.js
cp $DIR/README-bower-cometd-dojo.md $REPO/README.md
sed "s/__BOWER_TAG__/$BOWER_TAG/g" $DIR/bower-cometd-dojo.json > $REPO/bower.json

git add .

POM_VERSION=`grep "<version>" $POM_DIR/pom.xml | head -n 1 | tr -d '[[:space:]]' | sed 's|<version>||g' | sed 's|</version>||g'`

if [[ $POM_VERSION == *"SNAPSHOT"* ]]
then
    echo Snapshot version. Exiting
    exit
fi

git commit -m"Releasing $BOWER_TAG (cometd version $POM_VERSION)" || echo
git tag $BOWER_TAG
git push "https://${GH_TOKEN}@github.com/ffissore/bower-cometd-dojo.git" master --tags > /dev/null 2>&1

