#!/usr/bin/env bash

set -e
set -x

. src/sh/env.sh

if [ "$PACKAGE" == "" ]; then
	PACKAGE="*"
fi

if [ "$STAGE" == "" ]; then
	START_STAGE="0"
else
	START_STAGE="$STAGE"
fi

export PACKAGE START_STAGE

if [ ! -d .build ]; then
	mkdir .build
fi

cd .build

# execute stages
pushd ../src/sh/make.d
	export STAGES=$(find . -maxdepth 1 -mindepth 1 -type d | sed -e 's,^./,,' | sort)
popd

for STAGE in $STAGES; do
	[ "$STAGE" -ge "$START_STAGE" ] && ( find ../src/sh/make.d/$STAGE -type f -name "*.sh" | ( [ "$PACKAGE" == "*" ] && cat || grep "/$PACKAGE.sh$" ) | while read PKG_SCRIPT; do
		bash $PKG_SCRIPT > $SRCDIR/.build/$( basename $PKG_SCRIPT ).stdout 2> $SRCDIR/.build/$( basename $PKG_SCRIPT ).stderr
	done )
done

