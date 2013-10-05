<<<<<<< HEAD
# build id3.js

# output dir
DIR = dist
PRODUCTS = id3.min.js id3.dev.js
OUTPUTS = $(PRODUCTS:%=$(DIR)/%)
LIBS = id3.lib.js id3.core.js
CLOSURE_COMPILER ?= /usr/local/closure-compiler/compiler.jar

.PHONY: all clean
all: $(OUTPUTS)
# The lib and core files are intermediates, not needed after compilation
.INTERMEDIATE: $(LIBS)

# Search for JS files in src/
vpath %.js src

# Actual dependencies for each lib
$(DIR)/id3.lib.js: stringutils.js bufferedbinaryajax.js filereader.js base64.js
$(DIR)/id3.core.js: id3.js id3v1.js id3v2.js id3v2frames.js id4.js
$(DIR)/id3.dev.js: $(LIBS:%=$(DIR)/%)

$(DIR)/%.js:
	cat $^ > $@

$(DIR)/id3.min.js: $(DIR)/id3.dev.js
	java -jar $(CLOSURE_COMPILER) --compilation_level ADVANCED_OPTIMIZATIONS \
		--js $< > $@
=======
# build default.js
CLOSURE_COMPILER=/usr/local/closure-compiler/compiler.jar

# the default rule when someone runs simply `make`
all: \
	dist/id3.min.js \
	dist/id3.dev.js

.INTERMEDIATE dist/release/default.min.js: \
	default.core.js

.INTERMEDIATE dist/release/js/default.min.js: \
	default.core.js
	

id3.lib.js: \
	src/stringutils.js \
	src/bufferedbinaryajax.js \
	src/filereader.js \
	src/base64.js \

id3.core.js: \
	src/id3.js \
	src/id3v1.js \
	src/id3v2.js \
	src/id3v2frames.js \
	src/id4.js \


dist:

# assemble an uncompressed but complete library for development
dist/id3.min.js: dist id3.core.js id3.lib.js
	cat id3.lib.js \
		id3.core.js > dist/id3.dev.js

java -jar "$CLOSURE_COMPILER" \
    --compilation_level ADVANCED_OPTIMIZATIONS \
    --js id3.lib.js \
    --js id3.core.js \
> dist/id3.min.js


>>>>>>> c2b6033... Add Makefile

clean:
	rm -f dist/*
