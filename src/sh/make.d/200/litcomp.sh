#!/usr/bin/env bash

set -e
set -x

cd ../litcomp

export CXX_FLAGS="-I$PREFIX/include"
make
