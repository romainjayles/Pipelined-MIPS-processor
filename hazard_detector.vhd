----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:56 11/10/2015 
-- Design Name: 
-- Module Name:    hazard_detector - Behavioral 
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

entity hazard_detector is
    Port ( memory_read : in  STD_LOGIC;
				EX_reg_write: in STD_LOGIC_VECTOR(4 downto 0); -- destination register of load instruction
				ID_reg_a: in STD_LOGIC_VECTOR(4 downto 0); -- operand a of instruction in decode stage
				ID_reg_b: in STD_LOGIC_VECTOR(4 downto 0); -- operand b of instruction in decode
			 stall_pipeline: out STD_LOGIC
	 );
end hazard_detector;

architecture Behavioral of hazard_detector is
		

begin
	stall_pipeline <= '1' when ((memory_read = '1') 
	and (EX_reg_write = ID_reg_a)) 
	or ((EX_reg_write = ID_reg_b) 
	and (EX_reg_write /= "000000"))
	else '0';
	
end Behavioral;

