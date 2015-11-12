--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:03:23 09/26/2015
-- Design Name:   
-- Module Name:   /home/stefan/lab_comp_design/computer_design_1/alu_control_tb.vhd
-- Project Name:  lab_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu_control
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY alu_control_tb IS
END alu_control_tb;
 
ARCHITECTURE behavior OF alu_control_tb IS 
 
   --Inputs
   signal alu_op : std_logic_vector(1 downto 0) := (others => '0');
   signal func : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal alu_control : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 20 ns;
	
	procedure check (
      condition : in boolean;
      error_msg : in string) is
    begin  -- procedure check
      assert condition report error_msg severity failure;
    end procedure check;
 
BEGIN
 
	 DUT: entity work.alu_control
    PORT MAP(
         alu_op => alu_op,
         func => func,
         alu_control => alu_control
        );
 
   test: process
   begin		
       wait for clk_period;
		 alu_op <= b"00";
		 wait for clk_period;
		 check(alu_control = b"0010", "alu_control incorrect!");
		 report "Test 1 passed" severity note;
		 
		  wait for clk_period;
		 alu_op <= b"01";
		 wait for clk_period;
		 check(alu_control = b"0110", "alu_control incorrect!");
		 report "Test 2 passed" severity note;
		 
		  wait for clk_period;
		 alu_op <= b"10";
		 func <= b"100000";
		 wait for clk_period;
		 check(alu_control = b"0010", "alu_control incorrect!");
		 report "Test 3 passed" severity note;
		 
		   wait for clk_period;
		 alu_op <= b"10";
		 func <= b"100010";
		 wait for clk_period;
		 check(alu_control = b"0110", "alu_control incorrect!");
		 report "Test 4 passed" severity note;
		 
		   wait for clk_period;
		 alu_op <= b"10";
		 func <= b"100100";
		 wait for clk_period;
		 check(alu_control = b"0000", "alu_control incorrect!");
		 report "Test 5 passed" severity note;
		 
		   wait for clk_period;
		 alu_op <= b"10";
		 func <= b"100101";
		 wait for clk_period;
		 check(alu_control = b"0001", "alu_control incorrect!");
		 report "Test 6 passed" severity note;
		 
		    wait for clk_period;
		 alu_op <= b"10";
		 func <= b"101010";
		 wait for clk_period;
		 check(alu_control = b"0111", "alu_control incorrect!");
		 report "Test 7 passed" severity note;
			
		 report "SUCCESS" severity failure;
   end process;

END;
