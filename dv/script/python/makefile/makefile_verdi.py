
VERDI_OPTS      ?=
VERDI_WORK_MODE ?= hardwareDebug

ifeq ($(filter $(VERDI_WORK_MODE), hardwareDebug interactiveDebug powerDebug assertionDebug transactionDebug protocolDebug),)
 	$(error "invalid verdi work mode: $(VERDI_WORK_MODE)")
endif

VERDI_OPTS += -workMode $(VERDI_WORK_MODE)

.PHONY: clean

clean:
	@echo "echo"