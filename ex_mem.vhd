----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:24:43 10/27/2015 
-- Design Name: 
-- Module Name:    ex_mem - Behavioral 
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

entity ex_mem is
    Port ( 
			  reset : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  -- in register --------------
			  reg_write_control : in  STD_LOGIC;
           branch_control : in  STD_LOGIC;
           mem_read_control : in  STD_LOGIC;
			  add_result : in  STD_LOGIC_VECTOR(31 downto 0);
           zero : in  STD_LOGIC;
           alu_result : in  STD_LOGIC_VECTOR(31 downto 0);
           operand_b : in  STD_LOGIC_VECTOR(31 downto 0);
           write_reg : in  STD_LOGIC_VECTOR(4 downto 0);
			  -- out register --------------
           out_reg_write_control : out  STD_LOGIC;
           out_branch_control : out  STD_LOGIC;
           out_mem_read_control : out  STD_LOGIC;
			  out_add_result : out  STD_LOGIC_VECTOR(31 downto 0);
           out_zero : out  STD_LOGIC;
           out_alu_result : out  STD_LOGIC_VECTOR(31 downto 0);
           out_operand_b : out  STD_LOGIC_VECTOR(31 downto 0);
           out_write_reg : out  STD_LOGIC_VECTOR(4 downto 0)
			 );
end ex_mem;

architecture Behavioral of ex_mem is

begin
	process(clk, reset)
	begin
		if reset = '1' then
			out_reg_write_control <= '0';
			out_branch_control <= '0';
			out_mem_read_control <= '0';
			out_add_result <= (others => '0');
			out_zero <= '0';
			out_alu_result <= (others => '0');
			out_operand_b <= (others => '0');
			out_write_reg <= (others => '0');
		elsif rising_edge(clk) then
			out_reg_write_control <= reg_write_control;
			out_branch_control <= branch_control;
			out_mem_read_control <= mem_read_control;
			out_add_result <= add_result;
			out_zero <= zero;
			out_alu_result <= alu_result;
			out_operand_b <= operand_b;
			out_write_reg <= write_reg;
		end if;
	end process;

end Behavioral;

