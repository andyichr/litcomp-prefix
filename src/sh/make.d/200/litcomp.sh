#!/usr/bin/env bash

set -e
set -x

cd ../litcomp

export CXX_FLAGS="-I$PREFIX/include -L$PREFIX/lib"
#export TINYXML_LIB="$PREFIX/lib/libtinyxml.a"
export TINYXML_LIB="$(find $SRCDIR/.build/tinyxml/tinyxml -name "*.o" -not -name "*test*" | tr "\n" " ")"
make
