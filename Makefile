# build id3.js
CLOSURE_COMPILER=/usr/local/closure-compiler/compiler.jar

# the default rule when someone runs simply `make`
all: \
		dist/id3.min.js \
		dist/id3.dev.js

.INTERMEDIATE dist/id3.min.js: \
		id3.lib.js \
		id3.core.js

id3.lib.js: \
		src/stringutils.js \
		src/bufferedbinaryajax.js \
		src/filereader.js \
		src/base64.js \

id3%js:
		@cat $(filter %.js,$^) > $@

id3.core.js: \
		src/id3.js \
		src/id3v1.js \
		src/id3v2.js \
		src/id3v2frames.js \
		src/id4.js \

id3%js:
		@cat $(filter %.js,$^) > $@

dist:

# assemble an uncompressed but complete library for development
dist/id3.dev.js: dist id3.core.js id3.lib.js
		cat id3.lib.js \
				id3.core.js > dist/id3.dev.js

dist/id3.min.js: dist id3.core.js id3.lib.js
		java -jar $(CLOSURE_COMPILER) \
				--compilation_level ADVANCED_OPTIMIZATIONS \
				--js id3.lib.js \
				--js id3.core.js \
				> dist/id3.min.js



clean:
		rm -f dist/*
