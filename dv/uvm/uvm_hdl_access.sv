`define cust_uvm_hdl_deposit(path, vlaue) \
    if(uvm_hdl_check_path(`"path`"))begin   \
        uvm_hdl_deposit(`"path`", value); \
    end else begin  \
        `uvm_fatal("hdl_path", $sformatf("the given HDL path %s is not exits", path))   \
    end

`define cust_uvm_hdl_force(path, vlaue) \
    if(uvm_hdl_check_path(`"path`"))begin   \
        uvm_hdl_force(`"path`", value); \
    end else begin  \
        `uvm_fatal("hdl_path", $sformatf("the given HDL path %s is not exits", path))   \
    end

`define cust_uvm_hdl_force_time(path, vlaue, time) \
    if(uvm_hdl_check_path(`"path`"))begin   \
        uvm_hdl_force_time(`"path`", value, time); \
    end else begin  \
        `uvm_fatal("hdl_path", $sformatf("the given HDL path %s is not exits", path))   \
    end

`define cust_uvm_hdl_release_and_read(path, vlaue)  \
    if(uvm_hdl_check_path(`"path`"))begin   \
        uvm_hdl_release_and_read(`"path`", value); \
    end else begin  \
        `uvm_fatal("hdl_path", $sformatf("the given HDL path %s is not exits", path))   \
    end

`define cust_uvm_hdl_release(path)  \
    if(uvm_hdl_check_path(`"path`"))begin   \
        uvm_hdl_release(`"path`"); \
    end else begin  \
        `uvm_fatal("hdl_path", $sformatf("the given HDL path %s is not exits", path))   \
    end

`define cust_uvm_hdl_read(path, value)  \
    if(uvm_hdl_check_path(`"path`"))begin   \
        uvm_hdl_read(`"path`"); \
    end else begin  \
        `uvm_fatal("hdl_path", $sformatf("the given HDL path %s is not exits", path))   \
    end