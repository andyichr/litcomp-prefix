#!/usr/bin/env bash

set -e

export LITCOMP_HOME="$(pwd)/litcomp"
export LITCOMP_PREFIX_HOME="$(pwd)"
export PATH="$(pwd)/.prefix/bin:$PATH"
export LD_LIBRARY_PATH="$(pwd)/.prefix/lib"

./src/sh/make.sh "$(pwd)/.prefix"

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
	test -d "$LITCOMP_PREFIX_HOME/.prefix/var/litcomp-multi" || mkdir -p "$LITCOMP_PREFIX_HOME/.prefix/var/litcomp-multi"
	test -d "$LITCOMP_PREFIX_HOME/.prefix/var/litcomp-multi/wiki" || mkdir -p "$LITCOMP_PREFIX_HOME/.prefix/var/litcomp-multi/wiki"

	./bin/litcomp-multi "$(pwd)" <(cat <<EOF
{
	"litcomp-multi": {
		"base-url": "http://127.0.0.1:8071",
		"recaptcha": {
			"key": {
				"public": "6LcewcMSAAAAAFdNr1YCMwO4m6Naz62VFUSTQ0dR",
				"private": "6LcewcMSAAAAAHQB1XFNW2kUQLk2J05CxV6ItfwX"
			}
		},
		"data": {
			"provider": {
				"name": "filesystem",
				"config": {
					"path": "$LITCOMP_PREFIX_HOME/.prefix/var/litcomp-multi"
				}
			}
		}
	},
	"litcomp": {
		"home": "$LITCOMP_HOME",
		"data": {
			"provider": {
				"name": "filesystem",
				"config": {
					"path": "$LITCOMP_PREFIX_HOME/.prefix/var/litcomp-multi/wiki"
				}
			}
		}
	}
}
EOF
)
	;;
esac
