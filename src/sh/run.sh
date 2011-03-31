#!/usr/bin/env bash

set -e

./src/sh/make.sh "$(pwd)/.prefix"
export PATH="$(pwd)/.prefix/bin:$PATH"
export LD_LIBRARY_PATH="$(pwd)/.prefix/lib"

cd litcomp

case "$1" in
TEST)
	make test
	true
	;;
DOCS)
	make docs
	true
	;;
*)
	./bin/litcompd . test/wiki
	;;
esac
