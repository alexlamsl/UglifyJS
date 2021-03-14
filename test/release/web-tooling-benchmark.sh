#!/bin/sh

alias uglify-js="node --max-old-space-size=4096 $PWD/bin/uglifyjs"
UGLIFY_OPTIONS=$@

minify_in_situ() {
    ARGS="$UGLIFY_OPTIONS --validate --in-situ"
    DIRS="$1"
    echo '> uglify-js' $DIRS $UGLIFY_OPTIONS
    for i in `find $DIRS -name '*.js'`
    do
        ARGS="$ARGS $i"
    done
    uglify-js $ARGS
}

rm -rf tmp/web-tooling-benchmark \
&& git clone --depth 1 --branch v0.5.3 https://github.com/v8/web-tooling-benchmark.git tmp/web-tooling-benchmark \
&& cd tmp/web-tooling-benchmark \
&& rm -rf .git/hooks \
&& patch -l -p1 <<EOF
--- a/package.json
+++ b/package.json
@@ -12 +11,0 @@
-    "postinstall": "npm run build:terser-bundled && npm run build:uglify-js-bundled && npm run build",
--- a/src/chai-benchmark.js
+++ b/src/chai-benchmark.js
@@ -295 +295 @@ describe("assert", () => {
-    }).to.throw("expected {} to not be an instance of Foo");
+    }).to.throw(/^expected {} to not be an instance of /);
@@ -312 +312 @@ describe("assert", () => {
-    }).to.throw(AssertionError, "expected [Function: Foo] to be an object");
+    }).to.throw(AssertionError, /^expected \[Function: .*?] to be an object$/);
@@ -1086 +1086 @@ describe("expect", () => {
-    }).to.throw(AssertionError, "blah: expected 3 to be an instance of Foo");
+    }).to.throw(AssertionError, /^blah: expected 3 to be an instance of /);
@@ -1090 +1090 @@ describe("expect", () => {
-    }).to.throw(AssertionError, "blah: expected 3 to be an instance of Foo");
+    }).to.throw(AssertionError, /^blah: expected 3 to be an instance of /);
@@ -2143 +2143 @@ describe("expect", () => {
-    }).to.throw(AssertionError, ".empty was passed a function FakeArgs");
+    }).to.throw(AssertionError, /^\.empty was passed a function /);
@@ -2872 +2872 @@ describe("expect", () => {
-      /^blah: expected \[Function(: goodFn)*\] to throw an error$/
+      /^blah: expected \[Function.*?\] to throw an error$/
@@ -2879 +2879 @@ describe("expect", () => {
-      /^blah: expected \[Function(: goodFn)*\] to throw ReferenceError$/
+      /^blah: expected \[Function.*?\] to throw ReferenceError$/
@@ -2886 +2886 @@ describe("expect", () => {
-      /^blah: expected \[Function(: goodFn)*\] to throw 'RangeError: boo'$/
+      /^blah: expected \[Function.*?\] to throw 'RangeError: boo'$/
@@ -2893 +2893 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to not throw an error but 'Error: testing' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw an error but 'Error: testing' was thrown$/
@@ -2900 +2900 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw 'ReferenceError' but 'Error: testing' was thrown$/
+      /^blah: expected \[Function.*?\] to throw 'ReferenceError' but 'Error: testing' was thrown$/
@@ -2907 +2907 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw 'RangeError: boo' but 'Error: testing' was thrown$/
+      /^blah: expected \[Function.*?\] to throw 'RangeError: boo' but 'Error: testing' was thrown$/
@@ -2914 +2914 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to not throw 'Error' but 'Error: testing' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw 'Error' but 'Error: testing' was thrown$/
@@ -2921 +2921 @@ describe("expect", () => {
-      /^blah: expected \[Function(: refErrFn)*\] to not throw 'ReferenceError' but 'ReferenceError: hello' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw 'ReferenceError' but 'ReferenceError: hello' was thrown$/
@@ -2928 +2928 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw 'PoorlyConstructedError' but 'Error: testing' was thrown$/
+      /^blah: expected \[Function.*?\] to throw '.*?' but 'Error: testing' was thrown$/
@@ -2935 +2935 @@ describe("expect", () => {
-      /^blah: (expected \[Function(: ickyErrFn)*\] to not throw 'PoorlyConstructedError' but)(.*)(PoorlyConstructedError|\{ Object \()(.*)(was thrown)$/
+      /^blah: (expected \[Function.*?\] to not throw '.*?' but)(.*)(was thrown)$/
@@ -2942 +2942 @@ describe("expect", () => {
-      /^blah: (expected \[Function(: ickyErrFn)*\] to throw 'ReferenceError' but)(.*)(PoorlyConstructedError|\{ Object \()(.*)(was thrown)$/
+      /^blah: (expected \[Function.*?\] to throw 'ReferenceError' but)(.*)(was thrown)$/
@@ -2949 +2949 @@ describe("expect", () => {
-      /^blah: expected \[Function(: specificErrFn)*\] to throw 'ReferenceError: eek' but 'RangeError: boo' was thrown$/
+      /^blah: expected \[Function.*?\] to throw 'ReferenceError: eek' but 'RangeError: boo' was thrown$/
@@ -2956 +2956 @@ describe("expect", () => {
-      /^blah: expected \[Function(: specificErrFn)*\] to not throw 'RangeError: boo'$/
+      /^blah: expected \[Function.*?\] to not throw 'RangeError: boo'$/
@@ -2963 +2963 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw error not matching \/testing\/$/
+      /^blah: expected \[Function.*?\] to throw error not matching \/testing\/$/
@@ -2970 +2970 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw error matching \/hello\/ but got 'testing'$/
+      /^blah: expected \[Function.*?\] to throw error matching \/hello\/ but got 'testing'$/
@@ -2977 +2977 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw error matching \/hello\/ but got 'testing'$/
+      /^blah: expected \[Function.*?\] to throw error matching \/hello\/ but got 'testing'$/
@@ -2984 +2984 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw error matching \/hello\/ but got 'testing'$/
+      /^blah: expected \[Function.*?\] to throw error matching \/hello\/ but got 'testing'$/
@@ -2991 +2991 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw error including 'hello' but got 'testing'$/
+      /^blah: expected \[Function.*?\] to throw error including 'hello' but got 'testing'$/
@@ -2998 +2998 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to throw error including 'hello' but got 'testing'$/
+      /^blah: expected \[Function.*?\] to throw error including 'hello' but got 'testing'$/
@@ -3005 +3005 @@ describe("expect", () => {
-      /^blah: expected \[Function(: customErrFn)*\] to not throw an error but 'CustomError: foo' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw an error but 'CustomError: foo' was thrown$/
@@ -3012 +3012 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to not throw 'Error' but 'Error: testing' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw 'Error' but 'Error: testing' was thrown$/
@@ -3019 +3019 @@ describe("expect", () => {
-      /^blah: expected \[Function(: badFn)*\] to not throw 'Error' but 'Error: testing' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw 'Error' but 'Error: testing' was thrown$/
@@ -3026 +3026 @@ describe("expect", () => {
-      /^blah: expected \[Function(: emptyStringErrFn)*\] to not throw 'Error' but 'Error' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw 'Error' but 'Error' was thrown$/
@@ -3033 +3033 @@ describe("expect", () => {
-      /^blah: expected \[Function(: emptyStringErrFn)*\] to not throw 'Error' but 'Error' was thrown$/
+      /^blah: expected \[Function.*?\] to not throw 'Error' but 'Error' was thrown$/
@@ -3040 +3040 @@ describe("expect", () => {
-      /^blah: expected \[Function(: emptyStringErrFn)*\] to throw error not including ''$/
+      /^blah: expected \[Function.*?\] to throw error not including ''$/
@@ -3071 +3071 @@ describe("expect", () => {
-      /^(constructor: expected)(.*)(\[Function: Foo\])(.*)(to respond to \'baz\')$/
+      /^(constructor: expected)(.*)(\[Function: .*?\])(.*)(to respond to \'baz\')$/
@@ -3078 +3078 @@ describe("expect", () => {
-      /^(constructor: expected)(.*)(\[Function: Foo\])(.*)(to respond to \'baz\')$/
+      /^(constructor: expected)(.*)(\[Function: .*?\])(.*)(to respond to \'baz\')$/
@@ -3085 +3085 @@ describe("expect", () => {
-      /^(object: expected)(.*)(\{ foo: \[Function\] \}|\{ Object \()(.*)(to respond to \'baz\')$/
+      /^(object: expected)(.*)(\{ foo: \[Function.*?\] \}|\{ Object \()(.*)(to respond to \'baz\')$/
@@ -3092 +3092 @@ describe("expect", () => {
-      /^(object: expected)(.*)(\{ foo: \[Function\] \}|\{ Object \()(.*)(to respond to \'baz\')$/
+      /^(object: expected)(.*)(\{ foo: \[Function.*?\] \}|\{ Object \()(.*)(to respond to \'baz\')$/
@@ -3107 +3107 @@ describe("expect", () => {
-      /^blah: expected 2 to satisfy \[Function(: matcher)*\]$/
+      /^blah: expected 2 to satisfy \[Function.*?\]$/
@@ -3114 +3114 @@ describe("expect", () => {
-      /^blah: expected 2 to satisfy \[Function(: matcher)*\]$/
+      /^blah: expected 2 to satisfy \[Function.*?\]$/
--- a/src/cli.js
+++ b/src/cli.js
@@ -18,0 +19 @@ suite.on("error", event => {
+  global.process.exitCode = 42;
EOF
ERR=$?; if [ "$ERR" != "0" ]; then echo "Error: $ERR"; exit $ERR; fi
minify_in_situ "src" \
&& minify_in_situ "third_party" \
&& rm -rf node_modules \
&& npm ci \
&& rm -rf build/* \
&& npm run build:terser-bundled \
&& npm run build:uglify-js-bundled \
&& minify_in_situ "build" \
&& rm -rf dist \
&& npm run build \
&& minify_in_situ "dist" \
&& node dist/cli.js
