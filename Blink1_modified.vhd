library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity blink1 is
    Port ( clock : in  STD_LOGIC;
           led : out  STD_LOGIC;
			  led1 : out  STD_LOGIC);
end blink1;

architecture Behavioral of blink1 is

constant counterlimit : integer := 5000000; -- max

signal counter : unsigned(24 downto 0);
signal blink :std_logic;

begin

process(clock)
	begin
		
			if rising_edge(clock) then
			
				if counter = counterlimit then
					counter <= b"0000000000000000000000000";
					blink <= not blink;
					
				else
				
					counter <= counter +1;
				end if;
			end if;
			
		end process;
		
		led <= blink;
		led1 <= not blink;


end Behavioral;
