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

clean:
    rm -f dist/*
