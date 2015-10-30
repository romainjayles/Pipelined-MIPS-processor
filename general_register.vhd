library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity general_register is
  generic(
    number : natural := 32);            --number of registers

  port(
    clk: in std_logic;
    rst: in std_logic;
    reg_write: in std_logic; 
    read_reg_1 : in std_logic_vector(4 downto 0);
    read_reg_2 : in std_logic_vector(4 downto 0);
    write_register : in std_logic_vector(4 downto 0);
    write_data : in std_logic_vector(31 downto 0);
    read_data_1 : out std_logic_vector(31 downto 0);
    read_data_2 : out std_logic_vector(31 downto 0));
end entity general_register;

architecture Behavioral of general_register is
  subtype data is std_logic_vector(31 downto 0);  -- a standart data which can be in the register
  type register_array is array ((number-1) downto 0) of data;
  signal register_bench : register_array := (others => (others => '0'));

begin  -- behavioural


  process(clk, rst, reg_write) is
    begin
      if rst = '1' then
        register_bench <= (others => (others => '0'));
      elsif rising_edge(clk) and reg_write='1' then
        register_bench(to_integer(unsigned(write_register))) <= write_data;
      end if;
    end process;
      read_data_1 <= register_bench(to_integer(unsigned(read_reg_1)));
      read_data_2 <= register_bench(to_integer(unsigned(read_reg_2)));

end Behavioral;
    
