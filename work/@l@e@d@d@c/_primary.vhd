library verilog;
use verilog.vl_types.all;
entity LEDDC is
    port(
        DCK             : in     vl_logic;
        DAI             : in     vl_logic;
        DEN             : in     vl_logic;
        GCK             : in     vl_logic;
        Vsync           : in     vl_logic;
        mode            : in     vl_logic;
        rst             : in     vl_logic;
        \OUT\           : out    vl_logic_vector(15 downto 0)
    );
end LEDDC;
