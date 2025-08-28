MLTON       := mlton
MLTON_FLAGS :=

PREFIX  := /usr/local/mlton
BIN_DIR := $(PREFIX)/bin
LIB_DIR := $(PREFIX)/lib

ROOT    := $(shell readlink -f .)

TGT_PRE := $(ROOT)/target

LIB_DIR := $(ROOT)/src
LIB_MLB := $(LIB_DIR)/sources.mlb
LIB_TGT := $(TGT_PRE)/lib
LIB_DEP := $(LIB_MLB:.mlb=.mlb.d)

TST_DIR := $(ROOT)/test
TST_MLB := $(TST_DIR)/sources.mlb
TST_TGT := $(TGT_PRE)/test
TST_SRC := $(TST_MLB:.mlb=)
TST_EXE := $(TST_TGT)/sml-graph-lib-test
TST_DEP := $(TST_MLB:.mlb=.mlb.d)

DEPS_DIR          := $(ROOT)/.mlton
DEPS_BIN_DIR      := $(DEPS_DIR)/bin
SMLUNIT_DOC_DIR   := $(DEPS_DIR)/doc/smlunit-lib
SMLUNIT_DOC       := $(SMLUNIT_DOC_DIR)/api/index.html
SMLUNIT_LIB_DIR   := $(DEPS_DIR)/lib/SMLUnit
SMLUNIT_LIB       := $(SMLUNIT_LIB_DIR)/smlunit-lib.mlb
SMLFORMAT_EXE     := $(DEPS_BIN_DIR)/smlformat
SMLFORMAT_LIB_DIR := $(DEPS_DIR)/lib/SMLFormat
SMLFORMAT_LIB     := $(SMLFORMAT_LIB_DIR)/smlformat-lib.mlb
SMLDOC_EXE        := $(DEPS_BIN_DIR)/smldoc
DEPS              := $(SMLUNIT_LIB) $(SMLUNIT_DOC)

CACHE_DIR       := $(ROOT)/.cache
SMLUNIT_CACHE   := $(CACHE_DIR)/SMLUnit
SMLFORMAT_CACHE := $(CACHE_DIR)/smlformat
SMLDOC_CACHE    := $(CACHE_DIR)/smldoc
CACHE           := $(SMLUNIT_CACHE) $(SMLFORMAT_CACHE) $(SMLDOC_CACHE)

MLB_PATH_MAP := $(ROOT)/mlb-path-map


all: sml-graph-lib

deps: $(CACHE) $(DEPS)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# build steps
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

SML_GRAPH_LIB := $(LIB_TGT)/.sml-graph-lib.dummy

.PHONY: sml-graph-lib
sml-graph-lib: $(SML_GRAPH_LIB)

$(TST_DEP): MLTON_FLAGS += -mlb-path-var "SMLUNIT_LIB $(SMLUNIT_LIB_DIR)" -mlb-path-var "SML_GRAPH_LIB $(LIB_DIR)"
$(TST_DEP): $(LIB_MLB)
%.mlb.d: %.mlb
	@echo "  [GEN] $@"
	@$(SHELL) -ec '$(MLTON) $(MLTON_FLAGS) -stop f $< \
		| sed -e "1i$(<:.mlb=) $@:\\\\" -e "s|.*|  & \\\\|" -e "\$$s| \\\\||" > $@; \
		[ -s $@ ]'

ifeq ($(findstring clean,$(MAKECMDGOALS)),)
  include $(LIB_DEP)
endif

ifneq ($(findstring test,$(MAKECMDGOALS)),)
  include $(TST_DEP)
endif

$(SML_GRAPH_LIB): $(LIB_TGT)/.%.dummy: %.mlb | $(LIB_TGT)
	@echo "  [MLTON] $@"
	@$(MLTON) $(MLTON_FLAGS) -stop tc $<
	@echo "typecheck dummy with: $(MLTON) $(MLTON_FLAGS) -stop tc $<" > $@
	
$(LIB_TGT):
	mkdir -p $(LIB_TGT)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# build & run tests
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

.PHONY: test
test: $(TST_EXE)
	$(TST_EXE)

$(TST_EXE): $(TST_SRC) | $(TST_TGT)
	@echo "  [CP] $< -> $@"
	@cp $< $@

$(TST_SRC): MLTON_FLAGS += -mlb-path-var "SMLUNIT_LIB $(SMLUNIT_LIB_DIR)" -mlb-path-var "SML_GRAPH_LIB $(LIB_DIR)"
$(TST_SRC): $(TST_MLB) $(DEPS)
	@echo "  [MLTON] $@"
	@$(MLTON) $(MLTON_FLAGS) $<

$(TST_TGT):
	mkdir -p $(TST_TGT)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# manage dependencies
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

$(SMLUNIT_DOC): %: $(SMLUNIT_CACHE) $(SMLUNIT_LIB_DIR) $(SMLDOC_EXE) | $(DEPS_DIR)
	@echo "  [INSTALL DEPS] $@..."
	@cd $(SMLUNIT_CACHE) \
		&& PATH=$$PATH:$(DEPS_BIN_DIR) \
		&& $(MAKE) \
			-f $(SMLUNIT_CACHE)/Makefile.mlton \
			PREFIX=$(DEPS_DIR) \
			install-doc
	@echo "  [INSTALL DEPS] $@ installed"

$(SMLUNIT_LIB): $(SMLUNIT_CACHE) | $(DEPS_DIR)
	@echo "  [INSTALL DEPS] $(@F)..."
	@if [ ! -d "$(SMLUNIT_CACHE)/bin" ]; then \
		mkdir $(SMLUNIT_CACHE)/bin; \
	fi
	@cd $(SMLUNIT_CACHE) \
		&& $(MAKE) \
			-f $(SMLUNIT_CACHE)/Makefile.mlton \
			PREFIX=$(DEPS_DIR) \
			install-nodoc
	@echo "  [INSTALL DEPS] $(@F) installed at $@"

$(SMLFORMAT_EXE): $(SMLFORMAT_CACHE) | $(DEPS_DIR)
	@echo "  [INSTALL DEPS] $(@F)..."
	@cd $(SMLFORMAT_CACHE) \
		&& $(MAKE) \
			-f $(SMLFORMAT_CACHE)/Makefile.mlton \
			PREFIX=$(DEPS_DIR) \
			install-nodoc
	@echo "  [INSTALL DEPS] $(@F) installed at $@"

$(SMLDOC_EXE): $(SMLDOC_CACHE) $(SMLUNIT_LIB_DIR) $(SMLFORMAT_EXE) $(MLB_PATH_MAP) | $(DEPS_DIR)
	@echo "  [INSTALL DEPS] $(@F)..."
	export MLB_PATH_MAP=$(MLB_PATH_MAP); \
	cd $(SMLDOC_CACHE) \
		&& $(MAKE) \
			-f $(SMLDOC_CACHE)/Makefile.mlton \
			PREFIX=$(DEPS_DIR) \
			install
	@echo "  [INSTALL DEPS] $(@F) installed at $@"

$(MLB_PATH_MAP):
	@printf "SMLFORMAT_LIB $(SMLFORMAT_LIB_DIR)\nSMLUNIT_LIB $(SMLUNIT_LIB_DIR)\n" >> $(MLB_PATH_MAP)

$(CACHE): $(CACHE_DIR)/%: | $(CACHE_DIR)
	@if [ -d "$@" ]; then \
		echo "  [UPDATE DEPS] $(@F)..."; \
		cd $@ && git plo; \
		echo "  [UPDATE DEPS] $(@F) updated"; \
	else \
		echo "  [FETCH DEPS] $(@F)..."; \
		git clone git@github.com:smlsharp/$(@F) $@; \
		echo "  [FETCH DEPS] $(@F) cloned to $@"; \
	fi


$(CACHE_DIR):
	mkdir -p $(CACHE_DIR)

$(DEPS_DIR):
	mkdir -p $(DEPS_DIR)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #


# TODO: Later
# - [ ] write install target
#   needs the following:
#   - [x] typecheck source target
#   - [ ] create lib directory from PREFIX
#   - [ ] compile w/ -stop f from src/sources.mlb
#   - [ ] copy files listed in prev output to PREFIX/lib/sml-graph
#   - [ ] alert success

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# utility scripts
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

clean: clean-build

clean-all: clean clean-deps clean-cache

clean-build:
	-$(RM) -r $(TGT_PRE)
	-$(RM) ./**/*.mlb.d
	-$(RM) $(TST_SRC)

clean-deps:
	-$(RM) -r $(DEPS_DIR)
	-$(RM) $(MLB_PATH_MAP)

clean-cache:
	-$(RM) -r $(CACHE_DIR)
