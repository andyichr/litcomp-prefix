#!/usr/bin/env bash

set -e
set -x

export PERL_VERSION=$(pkg_version perl)

test -d perl || {
	rm -rf "perl-$PERL_VERSION"
	download "http://www.cpan.org/src/5.0/perl-$PERL_VERSION.tar.gz" | gunzip | tar x
	mv perl-$PERL_VERSION perl
}

cd "perl"
./Configure -des -Dprefix="$PREFIX"
make install
cat <<EOF | "$PREFIX/bin/cpan"
yes
yes
EOF
