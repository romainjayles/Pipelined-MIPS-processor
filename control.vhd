----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:19 10/27/2015 
-- Design Name: 
-- Module Name:    control - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control is
  port(
    instruction_in : in std_logic_vector(31 downto 0);
	 stall_hazard : in std_logic;
    regdst : out std_logic;
    branch : out std_logic;
    mem_read : out std_logic;
    mem_to_reg : out std_logic;
    alu_op : out std_logic_vector(1 downto 0);
    mem_write : out std_logic;
    alu_src : out std_logic;
    reg_write : out std_logic;
	 jump : out std_logic
	 );

end control;

    architecture Behavioral of control is
		signal opcode : std_logic_vector(5 downto 0);

		
    begin
		
		opcode <= instruction_in(31 downto 26);
		process(opcode, stall_hazard) is begin
				regdst <= '0';
				branch <= '0';
				mem_read <= '0';
				mem_to_reg <= '0';
				alu_op <= "00";
				mem_write <= '0';
				alu_src <= '0';
				reg_write <= '0';
				jump <= '0';
			if opcode = "000000" then -- R execution
				regdst <= '1';
				alu_op <= "10";
				reg_write <= '1';
				mem_to_reg <= '1';
			elsif opcode = "000010" or opcode = "000011" then -- J execution
				jump <= '1';
			elsif opcode = "100011" then -- LOAD execution
				reg_write <= '1';
				mem_read <= '1';
				alu_src <= '1';
			elsif opcode = "101011" then -- STORE execution
				alu_src <= '1';
				mem_write <= '1';
			elsif opcode = "000100" then -- BRANCH execution
				branch <= '1';
				alu_op <= "01";
			elsif opcode = "001111" then -- LUI execution
				reg_write <= '1';
				mem_to_reg <= '1';
				alu_src <= '1';
				alu_op <= "11";
			elsif stall_hazard = '1' then -- hazard, insert NOP
				regdst <= '0';
				branch <= '0';
				mem_read <= '0';
				mem_to_reg <= '0';
				alu_op <= "00";
				mem_write <= '0';
				alu_src <= '0';
				reg_write <= '0';
				jump <= '0';
			end if;
		
		end process;
		

    end Behavioral;

