#!/usr/bin/env bash

set -e
set -x

test -d expat || {
	rm -rf "expat-$(pkg_version expat)"
	curl http://downloads.sourceforge.net/project/expat/expat/$(pkg_version expat)/expat-$(pkg_version expat).tar.gz | gunzip | tar x
	mv expat-$(pkg_version expat) expat
}

cd "expat"
./configure --prefix="$PREFIX"
make
make install
