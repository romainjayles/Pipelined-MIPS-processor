----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:31:15 10/31/2015 
-- Design Name: 
-- Module Name:    stage_EX - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity stage_EX is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           in_pc : in  STD_LOGIC_VECTOR(31 downto 0);
           in_reg_a : in  STD_LOGIC_VECTOR(31 downto 0);
           in_reg_b : in  STD_LOGIC_VECTOR(31 downto 0);
           in_instruction20_16 : in  STD_LOGIC_VECTOR(4 downto 0);
           in_instruction15_11 : in  STD_LOGIC_VECTOR(4 downto 0);
           in_reg_dst_control : in  STD_LOGIC;
           in_branch_control : in  STD_LOGIC;
			  in_mem_read_control : in STD_LOGIC;
			  in_mem_write_control: in STD_LOGIC;
           in_alu_op_control : in  STD_LOGIC_VECTOR(1 downto 0);
           in_alu_src_control : in  STD_LOGIC;
			  in_immediate : in STD_LOGIC_VECTOR(31 downto 0);
			  in_reg_write_control : in  STD_LOGIC;
			  in_mem_to_reg_control : in STD_LOGIC;
			  
			  out_pc_imm_offcet : out STD_LOGIC_VECTOR(31 downto 0);
			  --out_pc_src_control : out STD_LOGIC;
			  out_branch_control : out STD_LOGIC;
			  out_mem_read_control : out STD_LOGIC;
			  out_mem_write_control: out STD_LOGIC;
			  out_alu_result : out STD_LOGIC_VECTOR(31 downto 0);
			  out_reg_b : out STD_LOGIC_VECTOR(31 downto 0);
			  out_write_reg : out STD_LOGIC_VECTOR(4 downto 0);
			  out_alu_zero : out STD_LOGIC;
			  out_reg_write_control : out  STD_LOGIC;
			  out_mem_to_reg_control : out STD_LOGIC
			  
			  );
			  
			  
end stage_EX;

architecture Behavioral of stage_EX is

	 signal operand_B :  STD_LOGIC_VECTOR(31 downto 0);
	 
	 signal pc_imm_offcet : STD_LOGIC_VECTOR(31 downto 0);
	 signal alu_result :  STD_LOGIC_VECTOR(31 downto 0);
	 signal write_reg : STD_LOGIC_VECTOR(4 downto 0);
	 signal alu_zero : STD_LOGIC;

	signal alu_op : STD_LOGIC_VECTOR(1 downto 0);
	signal func : STD_LOGIC_VECTOR(5 downto 0);
	signal alu_control :  STD_LOGIC_VECTOR(3 downto 0);
	
	signal immediate_shift    : STD_LOGIC_VECTOR(31 DOWNTO 0);

	
begin
-- instantiate ALU
MIPSalu : entity work.alu(Behavioral)
    port map (
      operand_A => in_reg_a,
      operand_B => operand_B ,
      result    => alu_result,
      zero      => alu_zero,
      control   => alu_control
      );	
---- istantiate alu control
  MIPSalu_control : entity work.alu_control(Behavioral)
  port map (
      alu_op      => alu_op,
      func        => func,
      alu_control => alu_control
   );
-- instantiate ex pipeline register
	MIPSex_mem : entity work.ex_mem(Behavioral)
    port map (
			  reset => reset,
			  clk => clk,
			  -- in register --------------
			  reg_write_control  => in_reg_write_control,
           branch_control  => in_branch_control,
           mem_read_control => in_mem_read_control,
			  mem_write_control => in_mem_write_control,
			  add_result => pc_imm_offcet,
           zero => alu_zero,
           alu_result => alu_result,
           operand_b => in_reg_b,
           write_reg => write_reg,
			  mem_to_reg_control => in_mem_to_reg_control,
			  -- out register --------------
           out_reg_write_control => out_reg_write_control,
           out_branch_control => out_branch_control,
			  out_mem_read_control => out_mem_read_control,
           out_mem_write_control  => out_mem_write_control,
			  out_add_result => out_pc_imm_offcet,
           out_zero => out_alu_zero,
           out_alu_result => out_alu_result,
           out_operand_b => out_reg_b,
           out_write_reg => out_write_reg,
			  out_mem_to_reg_control => out_mem_to_reg_control
      );	
-- alu and alu control connection	
	operand_B <= in_reg_b when (in_alu_src_control = '0') else in_immediate;
	alu_op <= in_alu_op_control;
	func <= in_immediate(5 downto 0);
--- end

-- pc relative addres calculation
	immediate_shift <= in_immediate(29 downto 0) & '0' & '0';
	pc_imm_offcet <= std_logic_vector(signed(in_pc) + signed(immediate_shift));
--- end
-- destination register selection
	write_reg  <= in_instruction20_16 when (in_reg_dst_control = '0') else in_instruction15_11;

	
	
end Behavioral;

