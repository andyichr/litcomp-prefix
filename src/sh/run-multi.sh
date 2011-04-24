#!/usr/bin/env bash

set -e

./src/sh/make.sh "$(pwd)/.prefix"
export PATH="$(pwd)/.prefix/bin:$PATH"
export LD_LIBRARY_PATH="$(pwd)/.prefix/lib"
export LITCOMP_HOME="$(pwd)/litcomp"

cd litcomp-multi

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
	test -d "$(pwd)/.prefix/var/litcomp-multi" || mkdir -p "$(pwd)/.prefix/var/litcomp-multi"

	./bin/litcomp-multi "$(pwd)" <(cat <<EOF
{
	"litcomp-multi": {
		"base-url": "http://127.0.0.1:8071",
		"data": {
			"provider": {
				"name": "filesystem",
				"config": {
					"path": "$(pwd)/.prefix/var/litcomp-multi"
				}
			}
		}
	},
	"litcomp": {
		"home": "$LITCOMP_HOME",
		"data": {
			"provider": {
				"name": "git",
				"config": {
					"repository": "git://..."
				}
			}
		}
	}
}
EOF
)
	;;
esac
