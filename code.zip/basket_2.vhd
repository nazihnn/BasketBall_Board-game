----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2023 14:28:10
-- Design Name: 
-- Module Name: palyer1 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity basket_2 is
 Port (
  
   X, Y: in unsigned (10 downto 0);
   RGB: out std_logic_vector (11 downto 0); 
   MASK: out std_logic
  );
end basket_2;

architecture Behavioral of basket_2 is
signal FLAG : std_logic;

begin


-- draws the net inbetween the x and y values specified bellow 
FLAG <= '1' when (X >= 5) and (X < 95)
            and (Y >= 175) and (Y < 200) else '0';
RGB <= "011101110111" when FLAG = '1' else (OTHERS => '0');
MASK <= FLAG;



end Behavioral;
