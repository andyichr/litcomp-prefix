#!/usr/bin/env bash

set -e
set -x

test -d tinyxml || {
	BUILD_DIR="$( pwd )"
	test -d tinyxml.tmp && rm -rf tinyxml.tmp
	mkdir tinyxml.tmp && cd tinyxml.tmp
	curl http://downloads.sourceforge.net/project/tinyxml/tinyxml/$(pkg_version tinyxml)/tinyxml_$(pkg_version tinyxml | sed -e 's/\./_/g').zip > tinyxml.zip
	unzip tinyxml.zip
	cd "$BUILD_DIR" && mv tinyxml.tmp tinyxml
}

cd tinyxml/tinyxml

export TIXML_USE_STL=YES
make
ar rcs libtinyxml.a tinystr.o tinyxmlerror.o tinyxml.o tinyxmlparser.o
test -d "$PREFIX"/lib || mkdir "$PREFIX"/lib
mv -f libtinyxml.a "$PREFIX"/lib/
test -d "$PREFIX"/include/tinyxml || mkdir -p "$PREFIX"/include/tinyxml
cp *.h "$PREFIX"/include/tinyxml/
