set -e
set -x

test -d haskell || {
	BUILD_DIR="$( pwd )"
	test -d haskell.tmp && rm -rf haskell.tmp
	mkdir haskell.tmp && cd haskell.tmp
	curl http://www.haskell.org/ghc/dist/$( pkg_version haskell )/ghc-$( pkg_version haskell )-src.tar.bz2 | bunzip2 | tar x
	cd "$BUILD_DIR" && mv haskell.tmp haskell
}

cd haskell/ghc*

./configure --prefix="$PREFIX"
make
set +e
make install
