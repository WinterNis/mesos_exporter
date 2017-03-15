#!/usr/bin/env bash

set -e
PROJECTNAME="mesos_exporter"

# make sure dirs exist
mkdir -p ./$PROJECTNAME-deb/usr/sbin/

echo "Building binary"
go build -o $PROJECTNAME

echo "Copy result of build"
cp ./mesos_exporter ./$PROJECTNAME-deb/usr/sbin/mesos_exporter

last_tag=$(git tag | sort -Vr | head -n 1)
last_tag=${last_tag:1}
echo "set revision to last tag : $last_tag"
sed -i "s/Version:.*/Version: $last_tag/g" ./$PROJECTNAME-deb/DEBIAN/control

echo "building debian package"
dpkg-deb --build $PROJECTNAME-deb .
