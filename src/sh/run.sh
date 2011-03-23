#!/usr/bin/env bash

./src/sh/make.sh "$(pwd)/.prefix"
export PATH="\"$(pwd)/.prefix/bin\":$PATH"
export LD_LIBRARY_PATH="$(pwd)/.prefix/lib"
./litcomp/bin/litcompd ./litcomp ./litcomp/test/wiki
