----------------------------------------------------------------------------------
-- Company: stem center  
-- Engineer:  hamada vlad
-- 
-- Create Date: 03.03.2023 14:48:07
-- Design Name: 
-- Module Name: Main_VGA - Behavioral
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
use IEEE.NUMERIC_STD.ALL;


entity Main_VGA is
  Port ( 
  -- vraiables needed for the final design 
   clk   : in std_logic;
   btnC :in std_logic;-- button needed 
   sw : in STD_LOGIC_VECTOR(15 downto 8);-- switches needed 
   Hsync          : out std_logic;
   Vsync          : inout std_logic;
   vgaRed,vgaGreen,vgaBlue : out std_logic_vector (3 downto 0)
  
  );
end Main_VGA;

architecture Behavioral of Main_VGA is

-- signals needed for the display 

    signal blank : std_logic;  
    signal rst : std_logic := '0';
    signal clk_out :std_logic;
    signal T_x : unsigned (10 downto 0);
    signal T_y : unsigned (10 downto 0);
    signal colours :std_logic_vector (11 downto 0);
    
    
    -- for player 
    signal T_RGB : std_logic_vector (11 downto 0);
    signal mask : std_logic;
    -- for basket 
    signal T_RGB2 : std_logic_vector (11 downto 0);
    signal MASK2 : std_logic;
    --for ball
    signal T_RGB3 : std_logic_vector (11 downto 0);
    signal MASK3 : std_logic;
    signal CX : natural := 550;
    signal CY : natural := 325 ;
    --for rest of basket
    signal T_RGB4 : std_logic_vector (11 downto 0);
    signal MASK4 : std_logic;   
     
begin
-- ports maps calling all the bottom modules files into the main file 
    clock: entity work.clock_divider port map(
      clk => clk, reset => rst, clock_out=> clk_out
    );
    
    vga : entity work.vga_controller_640_60 port map(
     hcount => T_x , vcount => T_y ,pixel_clk => clk_out,  rst => rst,
     blank=>blank , HS=>Hsync, VS=> Vsync
     
    );
    
    player_1 : entity work.palyer1 port map(
    X=> T_x, Y=> T_y, RGB=> T_RGB, MASK=> MASK 
    
    );
    hoop : entity work.basket port map(
    X=> T_x, Y=> T_y, RGB=> T_RGB2, MASK=> MASK2 
    
    );
    
    net : entity work.basket_2 port map(
    X=> T_x, Y=> T_y, RGB=> T_RGB4, MASK=> MASK4 
    
    );
    
    ball : entity work.disc port map(
    X=> T_x, Y=> T_y, RGB=> T_RGB3, MASK=> MASK3, CX=>CX, CY=> CY  
    
    );
    
    ball_movemnet : entity work.ball_movement port map(
     CX=>CX, CY=> CY , Vsync=>vsync, btnC=> btnC, sw => sw
    
    );
    
    
-- assigns the coulour of each shape to the signal colours which is used to diplay 
colours <= T_RGB when mask ='1' and blank = '0' else 
           T_RGB2 when MASK2='1' and blank = '0' else 
           T_RGB3 WHEN MASK3='1' and blank = '0' else 
           T_RGB4 WHEN MASK4='1' and blank = '0'  ;
  
  -- assigns each colour in the signal colurs in RGB order 
  vgaRed <= colours (11 downto 8);
  vgaGreen  <= colours (7 downto 4);
  vgaBlue <= colours (3 downto 0);    

end Behavioral;
