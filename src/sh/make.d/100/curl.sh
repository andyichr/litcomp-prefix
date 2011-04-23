#!/usr/bin/env bash

set -e
set -x

test -d curl || {
	BUILD_DIR="$( pwd )"
	test -d curl.tmp && rm -rf curl.tmp
	mkdir curl.tmp && cd curl.tmp
	download http://curl.haxx.se/download/curl-$(pkg_version curl).tar.bz2 | bunzip2 | tar x
	cd "$BUILD_DIR" && mv curl.tmp curl
}

cd curl/curl-$(pkg_version curl)

./configure --prefix="$PREFIX" --with-ssl="$PREFIX"
make
make install
