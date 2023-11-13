----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2023 15:22:34
-- Design Name: 
-- Module Name: clock_divider - Behavioral
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

entity clock_divider is
  Port ( 
  clk,reset: in std_logic;
    clock_out: out std_logic
  );
end clock_divider;

architecture Behavioral of clock_divider is

signal count: integer:=1;
signal tmp : std_logic := '0';
-- clock divider that divided the clock signla by the desired value 

begin

process(clk,reset)
    begin
        if(reset='1') then
            count<=1;
            tmp<='0';
        elsif(clk'event and clk='1') then
            count <=count+1;
            if (count = 2) then-- desired dividing value is 2, whihc gives an output of 50 MHz 
                tmp <= NOT tmp;
                count <= 1;
            end if;
        end if;
        clock_out <= tmp;
    end process;



end Behavioral;
