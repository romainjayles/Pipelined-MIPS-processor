----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:16:03 09/24/2015 
-- Design Name: 
-- Module Name:    alu - Behavioral 
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
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
-- ALU with no overflow handling
entity alu is
  Port (operand_A  : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
         operand_B : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
         result    : out STD_LOGIC_VECTOR(31 DOWNTO 0);
         zero      : out STD_LOGIC;
         control   : in  STD_LOGIC_VECTOR(3 DOWNTO 0));
end alu;

architecture Behavioral of alu is
  signal a_extended, b_extended : signed(31 downto 0);
  signal result_extended        : signed(31 downto 0);
  signal lui_shift              : signed(31 downto 0);
  --signal same_input_sign, different_result_sign  : std_logic;
  
begin

  a_extended              <= signed(operand_A);
  b_extended              <= signed(operand_B);
  lui_shift(31 downto 16) <= b_extended(15 downto 0);
  lui_shift(15 downto 0)  <= x"0000";
  result_extended         <= a_extended + b_extended when (control = b"0010") else  -- add
                      a_extended - b_extended   when (control = b"0110")                               else  -- subtract
                      a_extended and b_extended when (control = b"0000")                               else  -- AND
                      a_extended or b_extended  when (control = b"0001")                               else  -- OR
                      lui_shift                 when (control = b"1111")                               else  ---LUI
                      to_signed(1, 32)          when (control = b"0111") and (a_extended < b_extended) else  -- SLT
                      to_signed(0, 32)          when (control = b"0111") and (a_extended >= b_extended) else X"00000000";  -- SLT

  zero   <= '1' when (result_extended = to_signed(0, 32)) else '0';
  result <= std_logic_vector(result_extended(31 downto 0));
end Behavioral;

