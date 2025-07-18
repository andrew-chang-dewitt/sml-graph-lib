MLTON       := mlton
MLTON_FLAGS :=

INS_PRE := /usr/local/mlton
BIN_DIR := $(INS_PRE)/bin
LIB_DIR := $(INS_PRE)/lib

ROOT    := $(shell readlink -f .)

TGT_PRE := $(ROOT)/target

TST_SRC := $(ROOT)/test
TST_MLB := $(TEST_SRC)/sources.mlb
TST_TGT := $(TGT_PRE)/test
TST_EXE := $(TST_TGT)/sml-graph-lib-test

LIB_SRC := $(ROOT)/src
LIB_MLB := $(LIB_SRC)/sources.mlb
LIB_TGT := $(TGT_PRE)/lib

SMLUNIT_LIB_DIR := $(ROOT)/mlton/lib/SMLUnit


all: sml-graph-lib

clean:
	-$(RM) -rf $(TGT_PRE)


SML_GRAPH_LIB := $(LIB_TGT)/.sml-graph-lib.dummy

.PHONY: sml-graph-lib
sml-graph-lib: $(SML_GRAPH_LIB)

$(SML_GRAPH_LIB): $(LIB_TGT)/.%.dummy: %.mlb $(LIB_TGT)
	@echo "  [MLTON] $@"
	@$(MLTON) $(MLTON_FLAGS) -stop tc $<
	@echo "typecheck dummy with: $(MLTON) $(MLTON_FLAGS) -stop tc $<" > $@
	
$(LIB_TGT):
	mkdir -p $(LIB_TGT)


.PHONY: test
test: $(TST_EXE)
	$(TST_EXE)

$(TST_EXE): MLTON_FLAGS += -mlb-path-var "SMLUNIT_LIB $(SMLUNIT_LIB_DIR)"
$(TST_EXE): $(TST_SRC)/sources.mlb $(TST_TGT)
	@echo "  [MLTON] $@"
	@$(MLTON) $(MLTON_FLAGS) -output $@ $<

$(TST_TGT):
	mkdir -p $(TST_TGT)


# TODO: Later
# - [ ] write install target
#   needs the following:
#   - [ ] typecheck source target
#   - [ ] create lib directory from INS_PRE
#   - [ ] compile w/ -stop f from src/sources.mlb
#   - [ ] copy files listed in prev output to INS_PRE/lib/sml-graph
#   - [ ] alert success
