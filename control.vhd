----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:58:19 10/27/2015 
-- Design Name: 
-- Module Name:    control - Behavioral 
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

entity control is
  port(
    clk, reset : in std_logic;
    processor_enable : in std_logic;
    instruction_in : in std_logic_vector(31 downto 0);
    regdst : out std_logic;
    branch : out std_logic;
    mem_read : out std_logic;
    mem_to_reg : out std_logic;
    alu_op : out std_logic_vector(1 downto 0);
    mem_write : out std_logic;
    alu_src : out std_logic;
    reg_write : out std_logic;

    end control;

    architecture Behavioral of control is

        begin
              case instruction_in(31 downto 28) use
                    when "0000" =>
                  case instruction_in(27 downto 27) use
                        when '1' => null;
              when '0' => null;
              when others => null;
            end case;
              when  => ;
              when others => null;
            end case;
              when "0100" => null; --
              when others => null;
            end case;


            end Behavioral;

