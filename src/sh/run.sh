#!/usr/bin/env bash

./src/sh/make.sh "$(pwd)/.prefix"
export PATH="$(pwd)/.prefix/bin:$PATH"
export LD_LIBRARY_PATH="$(pwd)/.prefix/lib"

cd litcomp
make

[ "$1" == "TEST" ] && {
	make test
} || {
	./bin/litcompd . test/wiki
}
