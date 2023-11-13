----------------------------------------------------------------------------------
-- Company: wivenhoe hote
-- Engineer: hamda abaas
-- 
-- Create Date: 20.03.2023 12:41:02
-- Design Name: Game
-- Module Name: ball_movement - Behavioral
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
use ieee.std_logic_unsigned.all;



entity ball_movement is
  Port (
  --variable declaration 
  
    --X, Y: in unsigned (10 downto 0);
   --RGB: out std_logic_vector (11 downto 0); 
   --MASK: out std_logic;
    btnC : in  STD_LOGIC;
    sw : in STD_LOGIC_VECTOR(15 downto 8);
    Vsync          : inout std_logic;
    CX: inout natural := 550; 
    CY: inout natural := 325 
    
    --
  
   );
end ball_movement;


architecture Behavioral of ball_movement is

-- movmnet control using switches 
signal H_V : integer := to_integer(unsigned(sw(15 downto 12)))*8;
signal V_V : integer := to_integer(unsigned(sw(11 downto 8)))*5;
signal G : integer := 0;

signal score :std_logic_vector(2 downto 0):= "00" ;
signal FLAG : std_logic;
-- state machines declaration 
type state is (St1, St2);
signal c_state, n_state: state;



begin
-- counter process to change state when button is pressed 
counter : process 
    begin
        if rising_edge(btnC) then
          c_state <= n_state ;
           
        end if;
  
end process;


-- state machine
process(c_state)
   begin
        case (c_state) is
        
        when St1 => 
        -- orignal state, ball is with the player 
            CX <= 550 ; -- ball original position  
            CY<= 325 ;
            g <= 1;
            n_state <= St2;
            
         when St2 =>
       -- moving sate 
         
            IF rising_edge (Vsync) THEN -- ball moves when risng edge of vsync when the screen is refreshng 
            -- original state when the ball is thrown  
                     
                     G<= G+1;--  gravity value increases 
                     v_v<= v_v-1;
                    -- chnages the position of the ball so it moves 
                    CX <= CX - (H_V/16);
                    CY <= CY - (V_V/16);

                    if g > V_V then-- when the gravity value is high enough it chnages direction 

                        CX <= CX - (H_V/8) ;
                        CY<= CY +(V_V/8) ;-- ball moves down so the Y value increases 

                    end if ;
                    
                    if (CX >= 0) and (CX < 100) and (CY >= 150) and (CY < 175) THEN 
                        score <= SCORE + 1;
                    END IF ;
 
                END IF ;
            n_state <= St1;
    end case;
    END PROCESS;
    
--process(score)
--begin 

--case score is
--    when "001" =>
--                 FLAG <= '1' when (X >= 610) and (X < 620)and (Y >= 5) and (Y < 10) else '0';
--                RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
--                  MASK <= FLAG;
                  
--     when "010" =>
--             FLAG <= '1' when (X >= 600) and (X < 609)and (Y >= 5) and (Y < 10) else '0';
--            RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
--               MASK <= FLAG;
               
--    when "100" =>
--     FLAG <= '1' when (X >= 590) and (X < 599)and (Y >= 5) and (Y < 10) else '0';
--    RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
--    MASK <= FLAG;
    
--    when "011" =>
--                 FLAG <= '1' when (X >= 580) and (X < 589)and (Y >= 5) and (Y < 10) else '0';
--                RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
--                  MASK <= FLAG;
--     when "101" =>
--             FLAG <= '1' when (X >= 570) and (X < 579)and (Y >= 5) and (Y < 10) else '0';
--            RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
--               MASK <= FLAG;
               
--    when "110" =>
--     FLAG <= '1' when (X >= 560) and (X < 569)and (Y >= 5) and (Y < 10) else '0';
--    RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
--    MASK <= FLAG;
    
--    when "111" =>
--     FLAG <= '1' when (X >= 550) and (X < 559)and (Y >= 5) and (Y < 10) else '0';
--    RGB <= "000011110000" when FLAG = '1' else (OTHERS => '0');
--    MASK <= FLAG;
    
--    end case ;
--end process ;


end Behavioral;
