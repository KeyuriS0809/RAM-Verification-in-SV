# -------- USER INPUT --------
FILE     ?=
PACKAGE  ?=
TB_NAME  ?=
WAVE     ?= 0
 
# -------- DERIVED PATHS --------
DIR        := $(abspath $(dir $(FILE)))
SRC_FILE   := $(notdir $(FILE))
TB_FILE    := $(SRC_FILE:.sv=_tb.sv)
 
LOG_FILE   := sim.log
WAVE_FILE  := $(TB_NAME).vcd
 
## -------- CHECKS --------
#ifeq ($(strip $(FILE)),)
#$(error FILE not set. Example: make test FILE=Training/Wave/design.sv TB_NAME=tb_sine_gen)
#endif
#
#ifeq ($(strip $(TB_NAME)),)
#$(error TB_NAME not set)
#endif
 
# -------- DEFAULT TARGET --------
all: compile simulate
 
# -------- COMPILE --------
compile:
	@echo "Compiling in $(DIR)"
	@cd $(DIR) && \
    vsimsa -c -do " \
        vlib work; \
        vmap work work; \
        vlog -sv {$(SRC_FILE)} {$(TB_FILE)}; \
        quit; \
    "
 
# -------- SIMULATE --------
simulate:
	@echo "Simulating in $(DIR)"
	@cd $(DIR) && \
    vsimsa -c -l $(LOG_FILE) -do " \
        vsim +access+r work.$(TB_NAME); \
        if {$(WAVE) == 1} { \
            vcd file {$(WAVE_FILE)}; \
            vcd add -r /*; \
        }; \
        run -all; \
        quit; \
    "
 
# -------- CLEAN --------
clean:
	@echo "Cleaning generated files in $(DIR)"
	@rm -rf $(DIR)/work
	@rm -rf $(DIR)/compile
	@rm -rf $(DIR)/library.cfg
		@rm -f  $(DIR)/*.vcd
		@rm -f  $(DIR)/dataset.asdb
		@rm -f  $(DIR)/sim.log
 
.PHONY: all compile simulate test clean
