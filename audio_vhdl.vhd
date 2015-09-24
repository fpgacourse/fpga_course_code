----------------------------------------------------------------------------------
-- Engineer:       Mike Field <hamster@snap.net.nz>
-- 
-- Module Name:    audio_sos - Behavioral 
-- Description: Sends out a "... - - - ...     " using a saw tooth 
--              wave through a 1 bit dac
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity audio_sos is
    Port ( clk : in  STD_LOGIC;
           audio : out  STD_LOGIC_VECTOR (1 downto 0));
end audio_sos;

architecture Behavioral of audio_sos is
   signal nextDacSum1 : std_logic_vector(16 downto 0);
   signal nextDacSum2 : std_logic_vector(16 downto 0);
   
   type reg is record
      modulation : std_logic_vector(47 downto 0);
      counter : std_logic_vector(20 downto 0);
      dac_sum : std_logic_vector(15 downto 0);
      dac_out : std_logic;
   end record;
   signal r : reg := ( "10101000001110111011100000101010" & x"0000", (others => '0'), (others => '0'), '0');
   signal n : reg;

begin
   -- Assign the outputs
   audio <= r.dac_out & r.dac_out;
   
   -- the two options for the next value of the sigma/delta DAC
   nextDacSum1 <= ("0" & r.dac_sum(15 downto 0)) + r.counter(16 downto 1);
   nextDacSum2 <= ("0" & r.dac_sum(15 downto 0)) + "1000000000000000";
   
   process(r, nextDacSum1,nextDacSum2)
   begin
      n.counter <= r.counter + 1;
      
      -- shift the modulation through when the counter wraps
      if r.counter = "00000000000000000000" then
         n.modulation <= r.modulation(46 downto 0) & r.modulation(47);
      else
         n.modulation <= r.modulation;
      end if;
      
      -- decide if we make a tone or not
      if r.modulation(0) = '1' then
         n.dac_out <= nextDacSum1(16);
         n.dac_sum <= nextDacSum1(15 downto 0);
      else
         n.dac_out <= nextDacSum2(16);
         n.dac_sum <= nextDacSum2(15 downto 0);
      end if;
   end process;
   
   process (clk, n)
   begin
      if rising_edge(clk) then
         r <= n;
      end if;
   end process;
end Behavioral;
