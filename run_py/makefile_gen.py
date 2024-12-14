VHDLAN_OPTS ?=
VLOGAN_OPTS ?=
VCS_ELAB_OPTS ?=
VCS_SIM_OPTS ?=
VERDI_OPTS ?=

vhdl_analysis:
    vhdlan $(VHDLAN_OPTS)

verilog_analysis:
    vlogan $(VLOGAN_OPTS)

hardware_debug:
    verdi -ssf -workMode hardwareDebug $(VERDI_OPTS) &

interactive_debug:
    verdi -ssf -workMode interactiveDebug $(VERDI_OPTS) &

power_debug:
    verdi -ssf -workMode powerDebug $(VERDI_OPTS) &

assertion_debug:
    verdi -ssf -workMode assertionDebug $(VERDI_OPTS) &

transaction_debug:
    verdi -ssf -workMode transactionDebug $(VERDI_OPTS) &

protocol_debug:
    verdi -ssf -workMode protocolDebug $(VERDI_OPTS) &