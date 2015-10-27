----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:04 09/26/2015 
-- Design Name: 
-- Module Name:    alu_control - Behavioral 
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

entity alu_control is
    Port ( alu_op : in  STD_LOGIC_VECTOR(1 downto 0);
           func : in  STD_LOGIC_VECTOR(5 downto 0);
           alu_control : out  STD_LOGIC_VECTOR(3 downto 0));
end alu_control;

architecture Behavioral of alu_control is

begin
	alu_control <= b"0010" when (alu_op = b"00") else
						b"0110" when (alu_op = b"01") else
						b"1111" when (alu_op = b"11") else
						b"0010" when (alu_op = b"10") and (func = b"100000") else
						b"0110" when (alu_op = b"10") and (func = b"100010") else
						b"0000" when (alu_op = b"10") and (func = b"100100") else
						b"0001" when (alu_op = b"10") and (func = b"100101") else
						b"0111" when (alu_op = b"10") and (func = b"101010");
						

end Behavioral;

