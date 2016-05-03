#
# 'make'        build presentation file with pdflatex 
# 'make clean'  removes pdf and build folders
#

# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# The following variables may be overridden on the make command line in
PERL := perl
LATEXMK := $(PERL) scripts/latexmk.pl
BUILD_DIR := build
PDF_DIR := pdf


# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# Specify source tex files here
TEX_SRCS=examples/presentation.tex
#TEX_SRCS=examples/beamerexample-conference-talk.tex
#TEX_SRCS=examples/lipsum.tex


#Latex command
LATEXMK_CMD=TEXINPUTS=".//:$$TEXINPUTS:nlesc-beamer" $(LATEXMK) -pdf -pdflatex="pdflatex %O %S"
# for i in *.tex; do pdflatex $i;done
# ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ### ###
# 

.DEFAULT: all

.PHONY: all

all: $(addprefix $(PDF_DIR)/, $(TEX_SRCS:.tex=.pdf))

.PHONY: clean

clean:
	rm -rf "$(BUILD_DIR)" "$(PDF_DIR)"

$(PDF_DIR)/%.pdf: %.tex
	mkdir -p "$(BUILD_DIR)/$*"
	$(LATEXMK_CMD) -outdir="$(BUILD_DIR)/$*" "$<"
	mkdir -p "$(dir $@)"
	cp "$(BUILD_DIR)/$*/$(notdir $*).pdf" "$@"

