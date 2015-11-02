----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:51:11 10/28/2015 
-- Design Name: 
-- Module Name:    stage_ID - Behavioral 
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

entity stage_ID is
Port ( 
	 clk : in  std_logic;
	 rst : in std_logic;
	 pc_in : in std_logic_vector(31 downto 0);
	 reg_write : in std_logic;
	 instruction_in : in std_logic_vector(31 downto 0);
	 write_register : in std_logic_vector(4 downto 0);
	 write_data : in std_logic_vector(31 downto 0);
	 read_data_1 : out std_logic_vector(31 downto 0);
	 read_data_2 : out std_logic_vector(31 downto 0);
	 immediate_extended : out std_logic_vector(31 downto 0);
	 destination_R : out std_logic_vector(4 downto 0);
	 destination_I : out std_logic_vector(4 downto 0);
	 pc_out : out std_logic_vector(31 downto 0));
end stage_ID;

architecture Behavioral of stage_ID is
    
begin
register_file: entity work.general_register(Behavioral) port map(
		clk => clk,
		rst => rst,
		reg_write => reg_write,
		read_reg_1 => instruction_in(31 downto 0),
		read_reg_2 => instruction_in(31 downto 0),
		write_register => write_register,
		write_data => write_data,
		read_data_1 => read_data_1,
		read_data_2 => read_data_2
		);
		
		immediate_extended(15 downto 0) <= instruction_in(15 downto 0);
		immediate_extended(31 downto 16) <= (31 downto 16 => instruction_in(15));
		destination_R <= instruction_in(20 downto 16);
		destination_I <= instruction_in(15 downto 11);
		pc_out <= pc_in;
	 
end;
	 
	 
	 