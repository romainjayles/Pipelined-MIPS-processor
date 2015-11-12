--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:35:06 09/24/2015
-- Design Name:   
-- Module Name:   /home/stefan/lab_comp_design/computer_design_1/alu_tb.vhd
-- Project Name:  lab_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.all;
--use work.defs.all;
--use work.testutil.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alu_tb IS
END alu_tb;
 
ARCHITECTURE behavior OF alu_tb IS 
 
   --Inputs
   signal operand_A : std_logic_vector(31 downto 0) := (others => '0');
   signal operand_B : std_logic_vector(31 downto 0) := (others => '0');
   signal control : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(31 downto 0);
   signal zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 20 ns;
   -- component instantiation
  
 
	procedure check (
      condition : in boolean;
      error_msg : in string) is
    begin  -- procedure check
      assert condition report error_msg severity failure;
    end procedure check;

 
 
BEGIN
 
	DUT: entity work.alu
    port map (
			 operand_A => operand_A,
          operand_B => operand_B,
          result => result,
          zero => zero,
          control => control);
  -- clock generation
  --clk <= not clk after clk_period/2;

  ALU_run: process
  begin
    -- insert signal assignments here
    wait for clk_period; -- addition of positive numbers
	 operand_A <= x"00000001";
	 operand_B <= x"00000001";
	 control <= b"0010";
    wait for clk_period;
    check(result = x"00000002", "result incorrect!");
    report "Test 1 passed" severity note;

	 wait for clk_period; -- addition of positive and negative equal magnitude numbers
	 operand_A <= std_logic_vector(to_signed(-1, 32)); --minus 1
	 operand_B <= x"00000001";
	 control <= b"0010";
    wait for clk_period;
    check(result = x"00000000", "result incorrect!");
    report "Test 2 passed" severity note;
	 
	 wait for clk_period; -- addititon of positive and negative numbers, negative number magnitude is greater
	 operand_A <= std_logic_vector(to_signed(-10, 32)); --minus 1
	 operand_B <= x"00000001";
	 control <= b"0010";
    wait for clk_period;
    check(result = std_logic_vector(to_signed(-9, 32)), "result incorrect!");
    report "Test 3 passed" severity note;
	 
	 wait for clk_period; -- subtraction of positive and negative numbers, negative number magnitude is greater
	 operand_A <= std_logic_vector(to_signed(-10, 32)); --minus 1
	 operand_B <= x"00000001";
	 control <= b"0110";
    wait for clk_period;
    check(result = std_logic_vector(to_signed(-11, 32)), "result incorrect!");
    report "Test 4 passed" severity note;
	 
	 wait for clk_period; -- subtraction of positive numbers, expected result negative
	 operand_A <= x"00000001";
	 operand_B <= x"00000002";
	 control <= b"0110";
    wait for clk_period;
    check(result = std_logic_vector(to_signed(-1, 32)), "result incorrect!");
    report "Test 5 passed" severity note;
	 
	 wait for clk_period; -- subtraction of two negative numbers
	 operand_A <= std_logic_vector(to_signed(-10, 32)); --minus 1
	 operand_B <= std_logic_vector(to_signed(-8, 32));
	 control <= b"0110";
    wait for clk_period;
    check(result = std_logic_vector(to_signed(-2, 32)), "result incorrect!");
    report "Test 6 passed" severity note;
	 
	 wait for clk_period; -- AND
	 operand_A <= b"0001_0001_0100_0000_0000_0010_0010_0000"; 
	 operand_B <= b"0000_0001_0100_0000_0001_0000_0010_0000";
	 control <= b"0000";
    wait for clk_period;
    check(result = b"0000_0001_0100_0000_0000_0000_0010_0000", "result incorrect!");
    report "Test 7 passed" severity note;
	 
	 wait for clk_period; -- OR
	 operand_A <= b"0001_0001_0100_0000_0000_0010_0010_0000";
	 operand_B <= b"0000_0001_0100_0000_0001_0000_0010_0000";
	 control <= b"0001";
    wait for clk_period;
    check(result = b"0001_0001_0100_0000_0001_0010_0010_0000", "result incorrect!");
    report "Test 8 passed" severity note;
	 
	 
	 
	  wait for clk_period; -- SLT true condition, positive numbers
	 operand_A <= x"01000110"; 
	 operand_B <= x"11100101";
	 control <= b"0111";
    wait for clk_period;
    check(result = x"00000001", "result incorrect!");
    report "Test 9 passed" severity note;
	 
	 wait for clk_period; -- SLT false condition, positive numbers
	 operand_A <= x"11000110"; 
	 operand_B <= x"00000001";
	 control <= b"0111";
    wait for clk_period;
    check(result = x"00000000", "result incorrect!");
    report "Test 10 passed" severity note;
	 
	 wait for clk_period; -- SLT true condition, negative numbers
	 operand_A <= std_logic_vector(to_signed(-20, 32)); 
	 operand_B <=	std_logic_vector(to_signed(-9, 32));
	 control <= b"0111";
    wait for clk_period;
    check(result = x"00000001", "result incorrect!");
    report "Test 11 passed" severity note;
	 
	 wait for clk_period; -- SLT false condition, negative numbers
	 operand_A <= std_logic_vector(to_signed(-9, 32)); 
	 operand_B <=	std_logic_vector(to_signed(-20, 32));
	 control <= b"0111";
    wait for clk_period;
    check(result = x"00000000", "result incorrect!");
    report "Test 12 passed" severity note;
	 
	  wait for clk_period; -- test zero
	 operand_A <= std_logic_vector(to_signed(2, 32)); 
	 operand_B <=	std_logic_vector(to_signed(-2, 32));
	 control <= b"0010";
    wait for clk_period;
    check(zero = '1', "result incorrect!");
    report "Test 13 passed" severity note;
	 
	  wait for clk_period; -- test zero
	 operand_A <= std_logic_vector(to_signed(5, 32)); 
	 operand_B <=	std_logic_vector(to_signed(-2, 32));
	 control <= b"0010";
    wait for clk_period;
    check(zero = '0', "result incorrect!");
    report "Test 14 passed" severity note;
	 
	  wait for clk_period; -- test zero
	 operand_A <= std_logic_vector(to_signed(5, 32)); 
	 operand_B <=	b"0000_0000_0000_0000_1101_0000_0000_0000";
	 control <= b"1111";
    wait for clk_period;
    check(result = b"1101_0000_0000_0000_0000_0000_0000_0000", "result incorrect!");
    report "Test 15 passed" severity note;
	 
	 report "SUCCESS" severity failure;
	 
	end process;

END;
