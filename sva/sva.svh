`define SVA_FATAL(x) $fatal({$sformatf("SVA_FATAL %s(%0d) @ %0t: ", `__FILE__, `__LINE__, $time), `"x`"});
`define SVA_ERROR(x) $error({$sformatf("SVA_ERROR %s(%0d) @ %0t: ", `__FILE__, `__LINE__, $time), `"x`"});
`define SVA_WARNING(x) $warning({$sformatf("SVA_WARNING %s(%0d) @ %0t: ", `__FILE__, `__LINE__, $time), `"x`"});
`define SVA_INFO(x) $info({$sformatf("SVA_INFO %s(%0d) @ %0t: ", `__FILE__, `__LINE__, $time), `"x`"});
