library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity id_ex is
    Port ( 
			  reset : in STD_LOGIC;
			  clk : in STD_LOGIC;
			  -- in register --------------
			  regdst : in std_logic;
			  branch : in std_logic;
			  mem_read : in std_logic;
			  mem_to_reg : in std_logic;
			  alu_op : in std_logic_vector(1 downto 0);
			  mem_write : in std_logic;
			  alu_src : in std_logic;
			  reg_write : in std_logic;
			  read_data_1 : in std_logic_vector(31 downto 0);
			  read_data_2 : in std_logic_vector(31 downto 0);
			  immediate_extended : in std_logic_vector(31 downto 0);
			  destination_R : in std_logic_vector(4 downto 0);
			  destination_I : in std_logic_vector(4 downto 0);
			  pc_in : in std_logic_vector(31 downto 0);
			  -- out register --------------
			  out_regdst : out std_logic;
			  out_branch : out std_logic;
			  out_mem_read : out std_logic;
			  out_mem_to_reg : out std_logic;
			  out_alu_op : out std_logic_vector(1 downto 0);
			  out_mem_write : out std_logic;
			  out_alu_src : out std_logic;
			  out_reg_write : out std_logic;
			  out_read_data_1 : out std_logic_vector(31 downto 0);
			  out_read_data_2 : out std_logic_vector(31 downto 0);
			  out_immediate_extended : out std_logic_vector(31 downto 0);
			  out_destination_R : out std_logic_vector(4 downto 0);
			  out_destination_I : out std_logic_vector(4 downto 0);
			  pc_out : out std_logic_vector(31 downto 0)
			  
			 );
end id_ex;

architecture Behavioral of id_ex is

begin
	process(clk, reset)
	begin
		if reset = '1' then
			  out_regdst <= '0';
			  out_branch <= '0';
			  out_mem_read <= '0';
			  out_mem_to_reg <= '0';
			  out_alu_op <= (others => '0');
			  out_mem_write <= '0';
			  out_alu_src <= '0';
			  out_reg_write <= '0';
			  pc_out <= (others => '0');
			  out_read_data_1 <= (others => '0');
			  out_read_data_2 <= (others => '0');
			  out_immediate_extended <= (others => '0');
			  out_destination_R <= (others => '0');
			  out_destination_I <= (others => '0');
		elsif rising_edge(clk) then
			  out_regdst <= regdst;
			  out_regdst <= regdst;
			  out_mem_read <= mem_read;
			  out_mem_to_reg <= mem_to_reg;
			  out_alu_op <= alu_op;
			  out_mem_write <= mem_write;
			  out_alu_src <= alu_src;
			  out_reg_write <= reg_write;
			  out_read_data_1 <= read_data_1;
			  out_read_data_2 <= read_data_2;
			  out_immediate_extended <= immediate_extended;
			  out_destination_R <= destination_R;
			  out_destination_I <= destination_I;
			  pc_out <= pc_in;
		end if;
	end process;

end Behavioral;