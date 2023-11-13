----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.03.2023 14:34:41
-- Design Name: 
-- Module Name: circle - Behavioral
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

entity disc is
    generic (
 
        R : natural := 15);
       
    port (
     
       CX: in natural ; 
       CY: in natural ;
        X, Y: in unsigned (10 downto 0);
        RGB : out std_logic_vector(11 downto 0);
        MASK : out std_logic );
end disc;


architecture Mult of disc is
    signal DX, DY : unsigned (X'range);
    signal DX2,DY2 : unsigned ((2*X'high+1) downto 0);
    signal FLAG : std_logic;
    constant R2 : unsigned(DX2'range):= to_unsigned(R * R, DX2'length);
    
begin
--calculates the distance between the edge of the circle and the center of the ball 
    DX <= X - CX when X > CX else CX - X;
    DY <= Y - CY when Y > CY else CY - Y;
    DX2 <= DX * DX;
    DY2 <= DY * DY;
    -- fills is the value less than the square valye of the distance between x and y whihc encloses the are of the ball 
    FLAG <= '1' when (DX2 + DY2 < R2) else '0';
    RGB <= "111100000000" when FLAG = '1' else (OTHERS => '0');
    MASK <= FLAG;
end Mult;
