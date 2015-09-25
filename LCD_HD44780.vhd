library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lcd is
port ( clk : in std_logic;    ----clock i/p
       
		 lcd_rw : out std_logic;   ---read&write control
		 lcd_e  : out std_logic;   ----enable control
		 lcd_rs : out std_logic;   ----data or command control
		 data   : out std_logic_vector(7 downto 0));   ---data line
end lcd;

architecture Behavioral of lcd is
constant N: integer :=22; 
type arr is array (1 to N) of std_logic_vector(7 downto 0); 
constant datas : arr :=    (X"38",X"0c",X"06",X"01",X"C0",X"50",x"41",x"4e",x"54",x"45",x"43",x"48",x"20",x"53",x"4f",x"4c",x"55",
                                    x"54",x"49",x"4f",x"4e",X"53"); --command and data to display    
                                                                    -- p = 50, a = 41, n = 4e etc...											

begin
lcd_rw <= '0';  ----lcd write grounded as we dont move use read mode
process(clk)
variable i : integer := 0;
variable j : integer := 1;
begin

if clk'event and clk = '1' then           --display a character at 1000000
if i <= 1000000 then
i := i + 1;
lcd_e <= '1';
data <= datas(j)(7 downto 0);             --putchar from array
elsif i > 1000000 and i < 2000000 then    --wait state to go to next char 1000000
i := i + 1;
lcd_e <= '0';
elsif i = 2000000 then                    --end wait period 1000000 to 2000000
j := j + 1;
i := 0;
end if;                                    --advance character
if j <= 5  then
lcd_rs <= '0';    ---command signal        
lcd_rs <= '1';   ----data signal
end if;
if j = 22 then  ---repeated display of data  restart display
j := 5;
end if;
end if;

end process;
end Behavioral;


