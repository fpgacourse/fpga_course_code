library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test is
port (
      clk : in std_logic;
        dips : in std_logic_vector(3 downto 0);  --dips input
        sseg : out std_logic_vector(6 downto 0)  -- 7 bit decoded output.
    );
end test;
--'a' corresponds to MSB of sseg and g corresponds to LSB of sseg.
architecture Behavioral of test is

begin
	process (clk,dips)
		begin
		if (clk'event and clk='1') then
			case  dips is
				when "0000"=> sseg <="0000001";  -- '0'
				when "0001"=> sseg <="1001111";  -- '1'
				when "0010"=> sseg <="0010010";  -- '2'
				when "0011"=> sseg <="0000110";  -- '3'
				when "0100"=> sseg <="1001100";  -- '4'
				when "0101"=> sseg <="0100100";  -- '5'
				when "0110"=> sseg <="0100000";  -- '6'
				when "0111"=> sseg <="0001111";  -- '7'
				when "1000"=> sseg <="0000000";  -- '8'
				when "1001"=> sseg <="0000100";  -- '9'
		 --nothing is displayed when a number more than 9 is given as input.
				when others=> sseg <="1111111";
			end case;
		end if;

	end process;

end Behavioral;
