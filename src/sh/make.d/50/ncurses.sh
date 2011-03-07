set -e
set -x

test -d ncurses || {
	BUILD_DIR="$( pwd )"
	test -d ncurses.tmp && rm -rf ncurses.tmp
	mkdir ncurses.tmp && cd ncurses.tmp
	curl http://ftp.gnu.org/pub/gnu/ncurses/ncurses-$( pkg_version ncurses ).tar.gz | gunzip | tar x
	cd "$BUILD_DIR" && mv ncurses.tmp ncurses
}

cd ncurses/ncurses*

./configure --prefix="$PREFIX"
make
make install
