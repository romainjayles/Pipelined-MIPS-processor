----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:19:42 10/30/2015 
-- Design Name: 
-- Module Name:    IF_ID_register - Behavioral 
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

entity IF_ID_register is
    Port ( 
			  reset : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  -- in register --------------
			  pc_in : in STD_LOGIC_VECTOR(31 downto 0);
           instruction_in : in STD_LOGIC_VECTOR(31 downto 0);
			  -- out register --------------
           pc_out : out  STD_LOGIC_VECTOR(31 downto 0);
           instruction_out : out  STD_LOGIC_VECTOR(31 downto 0)
			  );
end IF_ID_register;

architecture Behavioral of IF_ID_register is

begin

process(clk, reset)
	begin
		if reset = '1' then
			pc_out <= (others => '0');
			instruction_out <= (others => '0');
		elsif rising_edge(clk) then
			pc_out <= pc_in;
			instruction_out <= instruction_in;
		end if;
	end process;
	
	
end Behavioral;

