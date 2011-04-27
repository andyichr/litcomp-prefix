#!/usr/bin/env bash

set -e
set -x

npm install http-proxy -g

patch $PREFIX/lib/node_modules/http-proxy/lib/node-http-proxy.js <<EOF
--- /tmp/orig	2011-04-26 12:11:32.645932994 -0400
+++ lib/node-http-proxy.js	2011-04-26 12:32:45.555932994 -0400
@@ -586,8 +586,8 @@
       remoteHost = options.host + (options.port - 80 === 0 ? '' : ':' + options.port);
 
   // Change headers
-  req.headers.host   = remoteHost;
-  req.headers.origin = 'http://' + options.host;
+  //req.headers.host   = remoteHost;
+  //req.headers.origin = 'http://' + options.host;
   
   outgoing = {
     host: options.host,
EOF
