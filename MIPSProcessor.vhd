-- Part of TDT4255 Computer Design laboratory exercises
-- Group for Computer Architecture and Design
-- Department of Computer and Information Science
-- Norwegian University of Science and Technology

-- MIPSProcessor.vhd
-- The MIPS processor component to be used in Exercise 1 and 2.

-- TODO replace the architecture DummyArch with a working Behavioral

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPSProcessor is
	generic (
		ADDR_WIDTH : integer := 8;
		DATA_WIDTH : integer := 32
	);
	port (
		clk, reset 				: in std_logic;
		processor_enable		: in std_logic;
		imem_data_in			: in std_logic_vector(DATA_WIDTH-1 downto 0);
		imem_address			: out std_logic_vector(ADDR_WIDTH-1 downto 0);
		dmem_data_in			: in std_logic_vector(DATA_WIDTH-1 downto 0);
		dmem_address			: out std_logic_vector(ADDR_WIDTH-1 downto 0);
		dmem_data_out			: out std_logic_vector(DATA_WIDTH-1 downto 0);
		dmem_write_enable		: out std_logic
	);
end MIPSProcessor;

architecture DummyArch of MIPSProcessor is
	signal counterReg : unsigned(31 downto 0);
	
	 signal reg_write : std_logic;
	 signal read_data_1 :  std_logic_vector(31 downto 0);
	 signal read_data_2 :  std_logic_vector(31 downto 0);
	 signal immediate_extended :  std_logic_vector(31 downto 0);
	 signal destination_R :  std_logic_vector(4 downto 0);
	 signal destination_I :  std_logic_vector(4 downto 0);
	 signal pc_out_stage_id : std_logic_vector(31 downto 0); 
	
	-- execute stage (use only inputs, outputs go into wb stage - i connect them myself, Stefan)
	---inputs
	signal in_pc :  STD_LOGIC_VECTOR(31 downto 0);
   signal in_reg_a :  STD_LOGIC_VECTOR(31 downto 0);
   signal in_reg_b :  STD_LOGIC_VECTOR(31 downto 0);
   signal in_instruction20_16 :  STD_LOGIC_VECTOR(4 downto 0);
   signal in_instruction15_11 :  STD_LOGIC_VECTOR(4 downto 0);
   signal in_reg_dst_control :  STD_LOGIC;
   signal in_branch_control :  STD_LOGIC;
	signal in_mem_read_control :  STD_LOGIC; -- as data memory has only one signal writeEnable
	signal in_mem_write_control:  STD_LOGIC;-- the following is performed: if mem_write_control = '1' then writeEnable = '1' 
														-- else if mem_read_control= '1' writeEnable = '0'
   signal in_alu_op_control :   STD_LOGIC_VECTOR(1 downto 0);
   signal in_alu_src_control :   STD_LOGIC;
	signal in_immediate :  STD_LOGIC_VECTOR(31 downto 0);
	signal in_reg_write_control :   STD_LOGIC;
	signal in_mem_to_reg_control :  STD_LOGIC;
	---- end inputs
	--- outputs
	signal out_pc_imm_offcet :  STD_LOGIC_VECTOR(31 downto 0);
	signal out_branch_control :  STD_LOGIC;
	signal out_mem_read_control :  STD_LOGIC;
	signal out_mem_write_control:  STD_LOGIC;
	signal out_alu_result :  STD_LOGIC_VECTOR(31 downto 0);
	signal out_reg_b :  STD_LOGIC_VECTOR(31 downto 0);
	signal out_write_reg :  STD_LOGIC_VECTOR(4 downto 0);
	signal out_alu_zero :  STD_LOGIC;
	signal out_reg_write_control :   STD_LOGIC;
	signal out_mem_to_reg_control :  STD_LOGIC;
 ---- end	
 
	-- outputs of write back pipeline stage
	signal wb_out_pc_src_control : STD_LOGIC;
	signal wb_out_write_data : STD_LOGIC_VECTOR(31 downto 0);
	signal wb_out_write_reg :  STD_LOGIC_VECTOR(4 downto 0);
	
   signal regdst :  std_logic;
   signal branch :  std_logic;
   signal mem_read :  std_logic;
   signal mem_to_reg :  std_logic;
   signal alu_op : std_logic_vector(1 downto 0);
   signal mem_write : std_logic;
   signal alu_src : std_logic;
			  
	----end
	
	-- instruction fetch stage  inputs
	---inputs
	signal if_in_processor_enable : std_logic;
	signal if_in_PCsrc : std_logic;
	signal if_in_PCbranch : std_logic_vector(31 downto 0);
	signal if_in_pc_enable : std_logic;
	signal if_in_imem_data_in : std_logic_vector(31 downto 0);
	-- end inputs
	
	-- instruction fetch stage  outputs
	---outputs
	signal if_out_instruction_out : std_logic_vector(31 downto 0);
	signal if_out_imem_address : std_logic_vector(31 downto 0);
	signal if_out_pc : std_logic_vector(31 downto 0);
	-- end outputs
	
	-- register IF_ID
	--inputs  -- the outputs of fetch stage
	--end inputs
	signal reg_if_id_instruction_out : std_logic_vector(31 downto 0);
	signal reg_if_id_pc_out : std_logic_vector(31 downto 0);
	
	
begin

	 -- instantiate instruction fetch pipeline stage
	MIPSstage_if : entity work.IF_stage(Behavioral)
    port map (
			reset => reset,
			clk => clk,
			processor_enable => if_in_processor_enable,
			PCsrc	=> if_in_PCsrc,			
			PCbranch	=>	if_in_PCbranch,	
			pc_enable => if_in_pc_enable,     
			instruction_out => if_out_instruction_out,
			imem_data_in => if_in_imem_data_in,  
			imem_address =>  if_out_imem_address,
			pc_out => if_out_pc

	);
	
	 -- instantiate instruction fetch decode  register 
	MIPSregister_if_id : entity work.if_id_register(Behavioral)
    port map (
			reset => reset,
			clk => clk,   
			instruction_in => if_out_instruction_out,
			pc_in => if_out_pc,
			instruction_out  => reg_if_id_instruction_out,
			pc_out  => reg_if_id_pc_out

	);
	
	

	-- instantiate execution pipeline stage
	MIPSstage_EX : entity work.stage_EX(Behavioral)
    port map (
			  clk => clk,
           reset => reset,
           in_pc => in_pc,
           in_reg_a => in_reg_a,
           in_reg_b => in_reg_b,
           in_instruction20_16 => in_instruction20_16,
           in_instruction15_11 => in_instruction15_11,
           in_reg_dst_control => in_reg_dst_control,
           in_branch_control => in_branch_control,
			  in_mem_read_control => in_mem_read_control,
			  in_mem_write_control => in_mem_write_control,
           in_alu_op_control => in_alu_op_control,
           in_alu_src_control => in_alu_src_control,
			  in_immediate => in_immediate,
			  in_reg_write_control => in_reg_write_control,
			  in_mem_to_reg_control => in_mem_to_reg_control,
			  
			  out_pc_imm_offcet => out_pc_imm_offcet,
			  out_branch_control => out_branch_control,
			  out_mem_read_control => out_mem_read_control,
			  out_mem_write_control => out_mem_write_control,
			  out_alu_result => out_alu_result,
			  out_reg_b => out_reg_b,
			  out_write_reg => out_write_reg,
			  out_alu_zero => out_alu_zero,
			  out_reg_write_control => out_reg_write_control,
			  out_mem_to_reg_control => out_mem_to_reg_control
	 );
	 
	 -- instantiate write back pipeline stage
	MIPSstage_wb : entity work.stage_wb(Behavioral)
    port map (
			  reset => reset,
			  clk => clk,
			  in_pc_imm_offcet => out_pc_imm_offcet,
			  in_branch_control => out_branch_control,
			  in_mem_read_control => out_mem_read_control,
			  in_mem_write_control => out_mem_write_control,
			  in_alu_result => out_alu_result,
			  in_reg_b => out_reg_b,
			  in_write_reg => out_write_reg,
			  in_alu_zero => out_alu_zero,
			  in_reg_write_control => out_reg_write_control,
			  in_mem_to_reg_control => out_mem_to_reg_control,
			  
			  in_procDMemReadData	=> dmem_data_in,
			  
			  out_pc_src_control => wb_out_pc_src_control,
			  out_write_data => wb_out_write_data,
			  out_write_reg => wb_out_write_reg,
			  
			  out_procDMemWriteEnable => dmem_write_enable,
			  out_procDMemWriteData		=> dmem_data_out,
			  out_procDMemAddr	=> dmem_address
	);
	
	
	MIPSstage_id : entity work.stage_ID(Behavioral)
   port map (
	 clk => clk,
	 rst => reset,
	 pc_in => if_out_pc,
	 reg_write => reg_write,
	 instruction_in => reg_if_id_instruction_out,
	 write_register => wb_out_write_reg,
	 write_data => wb_out_write_data,
	 read_data_1 => read_data_1,
	 read_data_2 => read_data_2,
	 immediate_extended => immediate_extended,
	 destination_R => destination_R,
	 destination_I => destination_I,
	 pc_out => pc_out_stage_id
	);
	
	MIPScontrol : entity work.control(Behavioral)
   port map (
	instruction_in => reg_if_id_instruction_out,
    regdst => regdst,
    branch => branch,
    mem_read => mem_read,
    mem_to_reg => mem_to_reg,
    alu_op => alu_op,
    mem_write => mem_write,
    alu_src => alu_src,
    reg_write => reg_write
	 );
	 
	 MIPSid_ex : entity work.id_ex(Behavioral)
   port map (
		reset => reset,
		clk => clk,
		regdst => regdst,
		branch => branch,
		mem_read => mem_read,
		mem_to_reg => mem_to_reg,
		alu_op => alu_op,
		mem_write => mem_write,
		alu_src => alu_src,
		reg_write => reg_write,
		read_data_1 => read_data_1,
		read_data_2 => read_data_2,
		immediate_extended => immediate_extended,
		destination_R => destination_R,
		destination_I => destination_I,
		pc_in => pc_out_stage_id,
		----output
		out_regdst => in_reg_dst_control,
		out_branch => in_branch_control,
		out_mem_read => in_mem_read_control,
		out_mem_to_reg => in_mem_to_reg_control,
		out_alu_op => in_alu_op_control,
		out_mem_write => in_mem_write_control,
		out_alu_src => in_alu_src_control,
		out_reg_write => in_reg_write_control,
		out_read_data_1 => in_reg_a,
		out_read_data_2 => in_reg_b,
		out_immediate_extended => in_immediate,
		out_destination_R => in_instruction20_16,
		out_destination_I => in_instruction15_11,
		pc_out => in_pc
	);

	DummyProc: process(clk, reset)
	begin
		if reset = '1' then
			counterReg <= (others => '0');
		elsif rising_edge(clk) then
			if processor_enable = '1' then
				counterReg <= counterReg + 1;
			end if;
		end if;
	end process;
	
	dmem_write_enable <= processor_enable;
	imem_address <= (others => '0');
	dmem_address <= std_logic_vector(counterReg(7 downto 0));
	dmem_data_out <= std_logic_vector(counterReg);

end DummyArch;

