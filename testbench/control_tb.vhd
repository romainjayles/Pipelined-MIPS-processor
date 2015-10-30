
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use work.defs.all;
use work.testutil.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY control_tb IS
END control_tb;
 
ARCHITECTURE behavior OF control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT control
    PORT(
         instruction_in : IN  std_logic_vector(31 downto 0);
         regdst : OUT  std_logic;
         branch : OUT  std_logic;
         mem_read : OUT  std_logic;
         mem_to_reg : OUT  std_logic;
         alu_op : OUT  std_logic_vector(1 downto 0);
         mem_write : OUT  std_logic;
         alu_src : OUT  std_logic;
         reg_write : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal instruction_in : std_logic_vector(31 downto 0) := (others => '0');
 	--Outputs
   signal regdst : std_logic;
   signal branch : std_logic;
   signal mem_read : std_logic;
   signal mem_to_reg : std_logic;
   signal alu_op : std_logic_vector(1 downto 0);
   signal mem_write : std_logic;
   signal alu_src : std_logic;
   signal reg_write : std_logic;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: control PORT MAP (
          instruction_in => instruction_in,
          regdst => regdst,
          branch => branch,
          mem_read => mem_read,
          mem_to_reg => mem_to_reg,
          alu_op => alu_op,
          mem_write => mem_write,
          alu_src => alu_src,
          reg_write => reg_write
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.

	report "Test begin" severity note;
   

	 instruction_in <= X"00000000";
	wait for 20ns;
	 instruction_in <= X"8C010001"; --lw
	 wait for 20ns;
	 -- in load_execution state
	 check(regdst = 	'0', 	"regdst result incorrect!");
	 check(alu_src = 	'1', 	"alu_src result incorrect!");
	 check(mem_to_reg = '1', 	"mem_to_reg result incorrect!");
	 check(reg_write = '1', 	"reg_write result incorrect!");
	 check(mem_read = 	'1', 	"mem_read result incorrect!");
	 check(mem_write = '0', 	"mem_write result incorrect!");
	 check(branch = 	'0', 	"branch result incorrect!");
	 check(alu_op = 	"00", "alu_op result incorrect!");
	report "Test 1 passed";
	wait for 20ns;
	instruction_in <= X"AC030005"; -- next state store_execution
	wait for 20ns;
	report "Test 2 passed";
	
	 check(regdst = 	'0', 	"regdst result incorrect!");
	 check(alu_src = 	'1', 	"alu_src result incorrect!");
	 check(mem_to_reg = '0', 	"mem_to_reg result incorrect!");
	 check(reg_write = '0', 	"reg_write result incorrect!");
	 check(mem_read = 	'0', 	"mem_read result incorrect!");
	 check(mem_write = '1', 	"mem_write result incorrect!");
	 check(branch = 	'0', 	"branch result incorrect!");
	 check(alu_op = 	"00", "alu_op result incorrect!");
	 report "Test 3 passed";

	 instruction_in <= X"00221820"; -- next state R_execution
	 wait for 20ns;
	report "Test 4 passed";
	
	 -- in R_execution
	 check(regdst = 	'1', 	"regdst result incorrect!");
	 check(alu_src = 	'0', 	"alu_src result incorrect!");
	 check(mem_to_reg = '0', 	"mem_to_reg result incorrect!");
	 check(reg_write = '1', 	"reg_write result incorrect!");
	 check(mem_read = 	'0', 	"mem_read result incorrect!");
	 check(mem_write = '0', 	"mem_write result incorrect!");
	 check(branch = 	'0', 	"branch result incorrect!");
	 check(alu_op = 	"10", "alu_op result incorrect!");
	 report "Test 5 passed";

   
	 instruction_in <= X"1000FFFD"; -- next state branch_execution
	 wait for 20ns;
	report "Test 6 passed";

	 -- in branch_execution
	 check(regdst = 	'0', 	"regdst result incorrect!");
	 check(alu_src = 	'0', 	"alu_src result incorrect!");
	 check(mem_to_reg = '0', 	"mem_to_reg result incorrect!");
	 check(reg_write = '0', 	"reg_write result incorrect!");
	 check(mem_read = 	'0', 	"mem_read result incorrect!");
	 check(mem_write = '0', 	"mem_write result incorrect!");
	 check(branch = 	'1', 	"branch result incorrect!");
	 check(alu_op = 	"01", "alu_op result incorrect!");
	 report "Test 7 passed";


	 instruction_in <= X"08000013"; -- next state jump_execution
	 wait for 20ns;
	report "Test 8 passed";
	 -- in branch_execution
	 check(regdst = 	'0', 	"regdst result incorrect!");
	 check(alu_src = 	'0', 	"alu_src result incorrect!");
	 check(mem_to_reg = '0', 	"mem_to_reg result incorrect!");
	 check(reg_write = '0', 	"reg_write result incorrect!");
	 check(mem_read = 	'0', 	"mem_read result incorrect!");
	 check(mem_write = '0', 	"mem_write result incorrect!");
	 check(branch = 	'0', 	"branch result incorrect!");
	 check(alu_op = 	"10", "alu_op result incorrect!");
	 report "Test 9 passed";
	 
	 
	
   end process;

END;
