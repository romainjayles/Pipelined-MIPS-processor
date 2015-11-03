--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:05:20 11/03/2015
-- Design Name:   
-- Module Name:   /home/camilo/computer_design/exercise_2/solution_v2/solution_v2/tb_forwarding_unit.vhd
-- Project Name:  solution_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Forwarding_unit
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
use work.defs.all;
use work.testutil.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_forwarding_unit IS
END tb_forwarding_unit;
 
ARCHITECTURE behavior OF tb_forwarding_unit IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Forwarding_unit
    PORT(
         ex_mem_regWrite : IN  std_logic;
         ex_mem_registerRd : IN  std_logic_vector(4 downto 0);
         mem_wb_regWrite : IN  std_logic;
         mem_wb_registerRd : IN  std_logic_vector(4 downto 0);
         id_ex_registerRs : IN  std_logic_vector(4 downto 0);
         id_ex_registerRt : IN  std_logic_vector(4 downto 0);
         fordward_a : OUT  std_logic_vector(1 downto 0);
         fordward_b : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    
	 

   --Inputs
   signal ex_mem_regWrite : std_logic := '0';
   signal ex_mem_registerRd : std_logic_vector(4 downto 0) := (others => '0');
   signal mem_wb_regWrite : std_logic := '0';
   signal mem_wb_registerRd : std_logic_vector(4 downto 0) := (others => '0');
   signal id_ex_registerRs : std_logic_vector(4 downto 0) := (others => '0');
   signal id_ex_registerRt : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal fordward_a : std_logic_vector(1 downto 0);
   signal fordward_b : std_logic_vector(1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clock_period : time := 10 ns;
	
	signal clock: std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Forwarding_unit PORT MAP (
          ex_mem_regWrite => ex_mem_regWrite,
          ex_mem_registerRd => ex_mem_registerRd,
          mem_wb_regWrite => mem_wb_regWrite,
          mem_wb_registerRd => mem_wb_registerRd,
          id_ex_registerRs => id_ex_registerRs,
          id_ex_registerRt => id_ex_registerRt,
          fordward_a => fordward_a,
          fordward_b => fordward_b
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		
	 report "Test begin" severity note;
    
     --wait for 100 ns;	

      wait for clock_period*4;

      -- insert stimulus here 
	
			-- test for EX hazard for operand A and B
			ex_mem_regWrite <= '1';
         ex_mem_registerRd <= "00001";
         mem_wb_regWrite <= '0' ;
         mem_wb_registerRd <= "00000";
         id_ex_registerRs <= "00001";
         id_ex_registerRt <= "00001";
			--check(fordward_a = 	"10", "fordward_a result incorrect!");
			--check(fordward_b = 	"10", "fordward_b result incorrect!");
			
	 report "Test 0 passed";
	 
	 wait for clock_period;
	 
	 -- test for MEM hazard for operand A and B
			ex_mem_regWrite <= '0';
         ex_mem_registerRd <= "00000";
         mem_wb_regWrite <= '1' ;
         mem_wb_registerRd <= "00001";
         id_ex_registerRs <= "00001";
         id_ex_registerRt <= "00001";
			--check(fordward_a = 	"01", "fordward_a result incorrect!");
			--check(fordward_b = 	"01", "fordward_b result incorrect!");
			
	 report "Test 1 passed";
	 
	 wait for clock_period;

-- test for no hazard for operand A and B
			ex_mem_regWrite <= '1';
         ex_mem_registerRd <= "01001";
         mem_wb_regWrite <= '1' ;
         mem_wb_registerRd <= "01000";
         id_ex_registerRs <= "00001";
         id_ex_registerRt <= "00001";
			--check(fordward_a = 	"00", "fordward_a result incorrect!");
			--check(fordward_b = 	"00", "fordward_b result incorrect!");
			
	 report "Test 2 passed";
	 
	 wait for clock_period;


	 
      --wait;
   end process;

END;
