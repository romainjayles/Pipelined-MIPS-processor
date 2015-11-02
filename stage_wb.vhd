----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:06:42 11/01/2015 
-- Design Name: 
-- Module Name:    stage_wb - Behavioral 
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

entity stage_wb is
    Port (
			  reset : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  in_pc_imm_offcet : in STD_LOGIC_VECTOR(31 downto 0);
			  in_branch_control : in STD_LOGIC;
			  in_mem_read_control : in STD_LOGIC;
			  in_mem_write_control: in STD_LOGIC;
			  in_alu_result : in STD_LOGIC_VECTOR(31 downto 0);
			  in_reg_b : in STD_LOGIC_VECTOR(31 downto 0);
			  in_write_reg : in STD_LOGIC_VECTOR(4 downto 0);
			  in_alu_zero : in STD_LOGIC;
			  in_reg_write_control : in STD_LOGIC;
			  in_mem_to_reg_control : in STD_LOGIC;
			  
			  in_procDMemReadData	:  in std_logic_vector(31 downto 0);
			  
			  out_pc_src_control : out STD_LOGIC;
			  --out_mem_to_reg_control : out STD_LOGIC;
			  out_write_data : out STD_LOGIC_VECTOR(31 downto 0);
			  out_write_reg : out STD_LOGIC_VECTOR(4 downto 0);
			  
			  out_procDMemWriteEnable : out std_logic;
			  out_procDMemWriteData		: out std_logic_vector(31 downto 0);
			  out_procDMemAddr				: out std_logic_vector(7 downto 0)
	 );
end stage_wb;

architecture Behavioral of stage_wb is
	signal read_data : STD_LOGIC_VECTOR(31 downto 0);
	signal alu_result : STD_LOGIC_VECTOR(31 downto 0);
	signal pc_src : STD_LOGIC;
	
begin

	MIPSmem_wb : entity work.mem_wb(Behavioral)
    port map (
			  reset => reset,
			  clk => clk,
			  pc_src => pc_src,
           read_data =>  in_procDMemReadData,
           --alu_result => in_alu_result,
           write_reg  => in_write_reg,
			  
			  out_pc_src => out_pc_src_control,
           out_read_data => read_data,
           --out_alu_result => alu_result,
           out_write_reg => out_write_reg
	);
	
	
	out_write_data <= read_data when (in_mem_to_reg_control = '0') else in_alu_result;
	out_procDMemWriteEnable <= '1' when (in_mem_write_control = '1') else
								  '0' when (in_mem_read_control = '1');
	pc_src <= in_branch_control AND in_alu_zero;
	out_procDMemAddr <= alu_result;
end Behavioral;

