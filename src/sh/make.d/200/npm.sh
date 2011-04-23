#!/usr/bin/env bash

set -x
set -e

export HOME="$PREFIX/lib/npm"
curl "http://npmjs.org/install.sh" | npm_install=rc sh

mv "$PREFIX/bin/npm" "$PREFIX/bin/npm.orig"

cat <<EOF > "$PREFIX/bin/npm"
#!/usr/bin/env bash

export HOME="$PREFIX/lib/npm"
npm.orig "\$@"
EOF

chmod +x "$PREFIX/bin/npm"
