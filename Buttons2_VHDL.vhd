library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity buttons is
    Port ( but : in  STD_LOGIC;
           but1 : in  STD_LOGIC;
           butext : in  STD_LOGIC;
           butext1 : in  STD_LOGIC;
           led : out  STD_LOGIC;
           led1 : out  STD_LOGIC;
           ledext : out  STD_LOGIC;
           ledext1 : out  STD_LOGIC);
end buttons;

architecture Behavioral of buttons is

begin

led <= but;
led1 <= but1;
ledext <= butext;
ledext1 <= butext1;


end Behavioral;
