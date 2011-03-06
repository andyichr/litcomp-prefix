#!/usr/bin/env bash

set -e

export PREFIX="$1"
export PATH="$PREFIX/bin":"$PATH"
export REINSTALL="$2"
export SRCDIR="$( pwd )"

reinstall()
{
	[ "$PACKAGE" != "*" ] || [ ! "$REINSTALL" == "reinstall" -a ! -f "$1" ]
}

export -f reinstall

installed()
{
	"$SRCDIR"/src/sh/installed.d/$1.sh
}

export -f installed

# output "=$PREFIX" for packages depending on installed status
prefixstr()
{
	installed $1 && echo "=\"$PREFIX\"" || true
}

export -f prefixstr

pkg_version()
{
	cat "$SRCDIR"/src/sh/version.d/$1
}

export -f pkg_version
