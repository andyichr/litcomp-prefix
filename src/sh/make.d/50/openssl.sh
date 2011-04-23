#!/usr/bin/env bash

set -e
set -x

test -d openssl || {
	BUILD_DIR="$( pwd )"
	test -d openssl.tmp && rm -rf openssl.tmp
	mkdir openssl.tmp && cd openssl.tmp
	download http://www.openssl.org/source/openssl-$(pkg_version openssl).tar.gz | gunzip | tar x
	cd "$BUILD_DIR" && mv openssl.tmp openssl
}

cd openssl/openssl-$(pkg_version openssl)

./config --prefix="$PREFIX" shared
make
make install
