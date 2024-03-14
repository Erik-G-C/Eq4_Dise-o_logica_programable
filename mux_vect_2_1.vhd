----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2022 10:52:40 AM
-- Design Name: 
-- Module Name: mux_vect_8_1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity mux_vect_2_1 is
    Port (  I0 : in STD_LOGIC_VECTOR (7 downto 0);
            I1 : in STD_LOGIC_VECTOR (7 downto 0);
           SEL : in STD_LOGIC_VECTOR (7 downto 0);
             F : out STD_LOGIC_VECTOR (7 downto 0));
end mux_vect_2_1;


architecture Behavioral of mux_vect_2_1 is

begin
        --asignación condicional concurrente
       -- F <= I0 when (SEL = '0') else
             --I1 ;
        process(SEL)
        begin
        case SEL is
        when X"11" => F <= I1;
        when X"13" => F <= I1;
        when X"14" => F <= I1;
        
        when X"01" => F <= I0;
        when others => NULL;
        end case;
        end process;

end Behavioral;
