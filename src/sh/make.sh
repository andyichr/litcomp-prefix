#!/usr/bin/env bash

set -e

. src/sh/env.sh

test "$PACKAGE" == "" && PACKAGE="*"
test "$STAGE" == "" && START_STAGE="0" || START_STAGE="$STAGE"
export PACKAGE START_STAGE

test -d .build || mkdir .build

# execute stages
cd "$SRCDIR"/src/sh/make.d
export STAGES=$( find . -maxdepth 1 -mindepth 1 -type d | sed -e 's,^./,,' | sort -n )
cd "$SRCDIR"

cd .build

for STAGE in $STAGES; do
	[ "$STAGE" -ge "$START_STAGE" ] && ( find ../src/sh/make.d/$STAGE -type f -name "*.sh" | ( [ "$PACKAGE" == "*" ] && cat || grep "/$PACKAGE.sh$" ) | while read PKG_SCRIPT; do
		PKG_NAME=$( basename $PKG_SCRIPT | sed -e 's/\..*//' )
		echo "build $PKG_NAME..."
		bash $PKG_SCRIPT > "$SRCDIR"/.build/$PKG_NAME.stdout 2> "$SRCDIR"/.build/$PKG_NAME.stderr && {
			echo "$PKG_NAME OK"
		} || {
			echo "Error: "
			set -x
			tail "$SRCDIR"/.build/$PKG_NAME.stderr
			set +x
			echo "Check .build/ for log output"
		}
	done )
done

