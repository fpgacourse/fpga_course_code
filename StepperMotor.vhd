-------------------------------------------------------
-- stepper_test.vhd - Driving a low cost stepper motor
--                    using a low cost driver board.
--                    Uses 'Full Step Drive' - see
--                    http://en.wikipedia.org/wiki/Stepper_motor
--
-- Author : Mike Field <hamster@snap.net.nz>
--
-------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity stepper_test is
    Port ( clk32M   : in   STD_LOGIC;
           -- Control signals
           sw_dir      : in   STD_LOGIC;
           sw_enable   : in   STD_LOGIC;
           sw_speed    : in   STD_LOGIC;
          
			 -- Outputs
          position : out  STD_LOGIC_VECTOR(15 downto 0);
          -- Signals to the drivers 
           phase_a  : out  STD_LOGIC;
           phase_b  : out  STD_LOGIC;
           phase_c  : out  STD_LOGIC;
           phase_d  : out  STD_LOGIC);
end stepper_test;

architecture Behavioral of stepper_test is
   signal coils       : std_logic_vector(3 downto 0) := "0011";
   signal count      : unsigned(17 downto 0) := (others => '0');
   signal step_count : unsigned(15 downto 0) := (others => '0');
begin
   phase_a <= coils(0);
   phase_b <= coils(1);
   phase_c <= coils(2);
   phase_d <= coils(3);
   position <= std_logic_vector(step_count);

p: process(clk32M) 
   begin
      if rising_edge(clk32M) then
         if count = 0 then
            if sw_enable = '1' then
               if sw_dir = '1' then
                  coils <= coils(0) & coils(coils'high downto 1);
                  step_count <= step_count + 1;
               else
                  coils <= coils(coils'high-1 downto 0) & coils(coils'high);
                  step_count <= step_count - 1;
               end if;
            end if;
         end if;
         
         -- Control the speed         
         if sw_speed = '1' and count =  64000-1 then
            -- 500 steps every second - fast
            count <= (others => '0');
         elsif count = 256000-1 then 
            -- 125 steps every second - slow
            count <= (others => '0');
         else
            count <= count + 1;
         end if;
      end if;
   end process;
end Behavioral;
