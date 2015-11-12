library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------------

entity general_register_tb is

end entity general_register_tb;

-------------------------------------------------------------------------------



architecture Behavioral of general_register_tb is

  -- component generics
  constant number : natural := 32;

  -- component ports
  signal rst              : std_logic     := '0';
  signal reg_write : std_logic := '0';
  signal read_reg_1 : std_logic_vector(4 downto 0);
  signal read_reg_2 : std_logic_vector(4 downto 0);
  signal write_register : std_logic_vector(4 downto 0);
  signal write_data : std_logic_vector(31 downto 0);
  signal read_data_1 : std_logic_vector(31 downto 0);
  signal read_data_2 : std_logic_vector(31 downto 0);

  -- clock
  constant clk_period : time      := 20 ns;
  signal clk          : std_logic := '1';

   procedure check (
      condition : in boolean;
      error_msg : in string) is
    begin  -- procedure check
      assert condition report error_msg severity failure;
    end procedure check;

-- test instructions
begin  -- architecture behavioural

  -- component instantiation
  DUT : entity work.general_register
    generic map (
      number => number)
    port map (
      clk         => clk,
      rst         => rst,
      reg_write => reg_write,
      read_reg_1 => read_reg_1,
      read_reg_2 => read_reg_2,
      write_register => write_register,
      write_data => write_data,
      read_data_1 => read_data_1,
      read_data_2 => read_data_2);

  -- clock generation
  clk <= not clk after clk_period / 2;

  -- waveform generation
  WaveGen_Proc : process
  begin
    report "Test begin" severity note;
    wait for clk_period/4;
    rst <= '1';
    wait for clk_period;
    rst <= '0';
    wait for clk_period;

    read_reg_1 <= "00001";
    wait for clk_period;
    check(read_data_1 = x"00000000", "Initialized value should be 0 (1)");
    report "Test1 passed" severity note;

    read_reg_2 <= "00011";
    wait for clk_period;
    check(read_data_2 = x"00000000", "Initialized value should be 0 (2)");
    report "Test2 passed" severity note;

    reg_write <= '1';
    write_register <= "00001";
    write_data <= x"EEEEEEEE";
    check(read_data_1 = x"00000000", "writing must wait 1 clk");
    report "Test3 passed" severity note;
    
    wait for clk_period;
    reg_write <= '0';
    write_data <= x"AAAAAAAA";
    check(read_data_1 = x"EEEEEEEE", "Data wasn't writen");
    report "Test4 passed" severity note;
    
    wait for clk_period;
    check(read_data_1 = x"EEEEEEEE", "Write enable doesn't work");
    report "Test5 passed" severity note;

    reg_write <= '1';
    write_register <= "00111";
    write_data <= x"CCCCCCCC";
    wait for clk_period;

    read_reg_2 <= "00111";
    wait for clk_period;
    check(read_data_2 = x"CCCCCCCC", "Other writing/reading failed");
    report "Test6 passed" severity note;

    
    assert false report "TEST SUCCESS" severity failure;

  end process WaveGen_Proc;

end architecture Behavioral;

-------------------------------------------------------------------------------

configuration general_register_tb_behavioural_cfg of general_register_tb is
  for Behavioral
  end for;
end general_register_tb_behavioural_cfg;

-------------------------------------------------------------------------------
