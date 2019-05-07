.PHONY := help
.DEFAULT_GOAL := help

# Directory structure
BINDIR := bin
LIBDIR := lib
MANDIR := man
WIKIDIR := wiki

# List scripts and libraries
ifneq ($(wildcard $(BINDIR)/),)
WIKI_DEPS += $(BINDIR)
SCRIPTS := $(sort $(shell find $(BINDIR) -type f -executable 2>/dev/null | sed "s/^$(BINDIR)\///"))
endif
ifneq ($(wildcard $(LIBDIR)/),)
WIKI_DEPS += $(LIBDIR)
LIBRARIES := $(sort $(shell find $(LIBDIR) -name '*.sh' 2>/dev/null | sed "s/^$(LIBDIR)\///"))
endif

# Deduce manpages and wikipages names from scripts and libraries
MANPAGES := $(addprefix $(MANDIR)/,$(addsuffix .1,$(SCRIPTS)) $(addsuffix .3,$(LIBRARIES)))
WIKIPAGES := $(addprefix $(WIKIDIR)/,$(addsuffix .md,$(SCRIPTS)) $(addsuffix .md,$(LIBRARIES)))


all: check-quality test ## Run quality and unit tests.

$(MANDIR)/%.1: $(BINDIR)/%
	shellman -tmanpage $< -o $@

$(MANDIR)/%.sh.3: $(LIBDIR)/%.sh
	shellman -tmanpage $< -o $@

$(WIKIDIR)/home.md: templates/wiki_home.md $(WIKI_DEPS)
	shellman -tpath:$< -o $@ \
	  --context scripts="$(SCRIPTS)" \
	            libraries="$(LIBRARIES)"

$(WIKIDIR)/_sidebar.md: templates/wiki_sidebar.md $(WIKI_DEPS)
	shellman -tpath:$< -o $@ \
	  --context scripts="$(SCRIPTS)" \
	            libraries="$(LIBRARIES)"

$(WIKIDIR)/%.md: $(BINDIR)/%
	shellman -twikipage $< -o $@

$(WIKIDIR)/%.sh.md: $(LIBDIR)/%.sh
	shellman -twikipage $< -o $@

man: $(MANPAGES) ## Generate man pages.

wiki: $(WIKIPAGES) $(WIKIDIR)/home.md $(WIKIDIR)/_sidebar.md ## Generate wiki pages.

doc: man wiki ## Generate man pages and wiki pages.

readme: templates/readme*  ## Generate the README.
	jinja2 templates/readme.md cookiecutterrc.yml > README.md 2>/dev/null

check-style: ## Run the style tests.
	bats tests/quality/test_shellcheck.bats

check-documentation: ## Run the documentation tests.
	bats tests/quality/test_shellman.bats

check-quality: ## Run the quality tests.
	bats tests/quality/*.bats

test: ## Run the unit tests.
	bats tests/*.bats

help: ## Print this help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
