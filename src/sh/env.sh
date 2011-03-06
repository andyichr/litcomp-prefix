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

prep_latest()
{
	PROJ_BASE_URL="$2"
	PROJ_FILE=$( curl -s $PROJ_BASE_URL | grep -o "$3" | tail -n1 )
	PROJ_VERSION=$( echo "$PROJ_FILE" | sed -e "s/$4$//" )
	PROJ_URL="${PROJ_BASE_URL}${PROJ_FILE}"
	if [ ! -e "$PROJ_FILE" ]; then
		echo "Retrieving: $PROJ_URL"
		curl "$PROJ_URL" -o "$PROJ_FILE.tmp"
		mv "$PROJ_FILE.tmp" "$PROJ_FILE"
	fi
	tar xf "$PROJ_FILE"
	pushd $( find . -maxdepth 1 -type d -name "$1*" | head -n1 )
}

export -f prep_latest
