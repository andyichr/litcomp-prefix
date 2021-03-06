#!/usr/bin/env bash

set -e
set -x

test -d nodejs || {
	BUILD_DIR="$( pwd )"
	test -d nodejs.tmp && rm -rf nodejs.tmp
	mkdir nodejs.tmp && cd nodejs.tmp
	download http://nodejs.org/dist/node-v$(pkg_version nodejs).tar.gz | gunzip | tar x
	cd "$BUILD_DIR" && mv nodejs.tmp nodejs
}

cd nodejs/node-v$(pkg_version nodejs)

./configure --prefix="$PREFIX" --openssl-includes="$PREFIX"/include --openssl-libpath="$PREFIX"/lib
make
make install

mv "$PREFIX/bin/node" "$PREFIX/bin/node.orig"

cat <<EOF > "$PREFIX/bin/node"
#!/usr/bin/env bash

export NODE_PATH="$PREFIX/lib/node_modules:\$NODE_PATH"
exec node.orig "\$@"
EOF

chmod +x "$PREFIX/bin/node"
