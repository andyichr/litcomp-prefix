#!/usr/bin/env bash

set -e
set -x

test -d tinyxml || {
	BUILD_DIR="$( pwd )"
	test -d tinyxml.tmp && rm -rf tinyxml.tmp
	mkdir tinyxml.tmp && cd tinyxml.tmp
	curl http://downloads.sourceforge.net/project/tinyxml/tinyxml/$( pkg_version tinyxml)/tinyxml_$( pkg_version tinyxml | sed -e 's/\./_/g' ).zip | unzip
	cd "$BUILD_DIR" && mv tinyxml.tmp tinyxml
}

cd tinyxml/tinyxml*

./configure --prefix="$PREFIX"
make
make install
