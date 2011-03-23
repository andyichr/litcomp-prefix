#!/usr/bin/env bash

./src/sh/make.sh "$(pwd)/.prefix"
export PATH="$(pwd)/.prefix/bin:$PATH"
export LD_LIBRARY_PATH="$(pwd)/.prefix/lib"
pushd litcomp
	ant dist
	make
popd
./litcomp/bin/litcompd "$(pwd)"/litcomp "$(pwd)"/litcomp/test/wiki
