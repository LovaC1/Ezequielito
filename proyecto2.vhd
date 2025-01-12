library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Para operaciones aritméticas con std_logic_vector

entity GAL2 is
    Port (
        clk, clk_disp, a1, a2, a3, a4, d1, d2, d3 : in  STD_LOGIC;
        qa, qb, qc, qd, qe, qf, qg, s1, s2, s3 : out  STD_LOGIC
      );
end GAL2;

architecture Behavioral of GAL2 is
    signal num : STD_LOGIC_VECTOR(3 downto 0);
    signal display_select : STD_LOGIC_VECTOR(2 downto 0);
    signal display_values : STD_LOGIC_VECTOR(6 downto 0);
    signal count_disp : integer range 0 to 2 := 0;
begin
    process(clk_disp)
    begin
        if clk_disp'event and clk_disp = '1' then
            if count_disp = 2 then
                count_disp <= 0;
            else
                count_disp <= count_disp +1;
            end if;
        endif;
    end process;

    process(clk)
      if clk'event and clk = '1' then
        num <= a1 & a2 & a3 & a4;
        case num is
          when "0000" => display_values <= "1111110";  -- 0
          when "0001" => display_values <= "0110000";  -- 1
          when "0010" => display_values <= "1101101";  -- 2
          when "0011" => display_values <= "1111001";  -- 3
          when "0100" => display_values <= "0110011";  -- 4
          when "0101" => display_values <= "1011011";  -- 5
          when "0110" => display_values <= "1011111";  -- 6
          when "0111" => display_values <= "1110000";  -- 7
          when "1000" => display_values <= "1111111";  -- 8
          when "1001" => display_values <= "1111011";  -- 9
          when others => display_values <= "0000000";  -- Default (apagar)
        end case;
      end if;
    end process;
    process(count_disp, d1, d2, d3)
    begin
        case count_disp is
            when 0 => 
                if d1 = '1' then
                    s1 <= '1'; s2 <= '0'; s3 <= '0';
                    qa <= display_values(0);
                    qb <= display_values(1);
                    qc <= display_values(2);
                    qd <= display_values(3);
                    qe <= display_values(4);
                    qf <= display_values(5);
                    qg <= display_values(6);
                else
                    s1 <= '0';
                end if;

            when 1 =>
                if d2 = '1' then
                    s1 <= '0'; s2 <= '1'; s3 <= '0';
                    qa <= display_values(0);
                    qb <= display_values(1);
                    qc <= display_values(2);
                    qd <= display_values(3);
                    qe <= display_values(4);
                    qf <= display_values(5);
                    qg <= display_values(6);
                else
                    s2 <= '0';
                end if;

            when 2 => 
                if d3 = '1' then
                    s1 <= '0'; s2 <= '0'; s3 <= '1';
                    qa <= display_values(0);
                    qb <= display_values(1);
                    qc <= display_values(2);
                    qd <= display_values(3);
                    qe <= display_values(4);
                    qf <= display_values(5);
                    qg <= display_values(6);
                else
                    s3 <= '0';
                end if;

            when others => 
                s1 <= '0'; s2 <= '0'; s3 <= '0';
        end case;
    end process;

end Behavioral;
