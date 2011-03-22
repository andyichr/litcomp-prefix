#!/usr/bin/env bash

set -x
set -e

echo "Y" | "$PREFIX/bin/cpan" JSON
