----------------------------------------------------------------------------------
-- Multiplexor que selecciona el puerto de lectura que accede el PicoBlaze
-- Este mux muestra un dato al leerse el puerto X"01"
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux_reg_entrada is
    Port ( 
                MUX_ENTRADA : in  STD_LOGIC_VECTOR (7 downto 0);
                 MUX_SALIDA : out STD_LOGIC_VECTOR (7 downto 0);
                --pines de comunicación con Picoblaze
                    PORT_ID : in  STD_LOGIC_VECTOR (7 downto 0)
           );
end mux_reg_entrada;

architecture Behavioral of mux_reg_entrada is

--direcciones de los puertos del puerto de entrada
--solo se incluyen los que implican leer del modulo
constant LEE_PUERTO 		: std_logic_vector(7 downto 0) := X"01";

begin
		process(MUX_ENTRADA, PORT_ID)
		begin
				--salida por omisión
				MUX_SALIDA <= (others => '0');
				--
				case(PORT_ID) is
						when LEE_PUERTO =>    
						                      MUX_SALIDA <= MUX_ENTRADA;
						                      
						when others     =>    NULL;
				end case;
		end process;
end Behavioral;
