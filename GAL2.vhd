library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity caja is
    Port(
		clk: in std_logic;
		num: in std_logic_vector(3 downto 0);
		dp: in std_logic_vector(2 downto 0);
		seg: in std_logic_vector(6 downto 0);
		an: out std_logic_vector(2 downto 0)	
    );
end caja;

architecture Behavioral of caja is
	signal cont: std_logic_vector(1 downto 0);
	signal segs: std_logic_vector(6 downto 0);
	signal ans: std_logic_vector(2 downto 0);
	signal seg1, seg2, seg3: std_logic_vector(6 downto 0):= "1111110";
begin
    process (clk)
	begin
		if clk'event and clk = '1' then
			-- Contador selector del display
			cont(0) <= not cont(0);
			cont(1) <= cont(1) xor cont(0);
			if cont = "11" then
				cont(0) <= '0';
				cont(1) <= '0';
			end if;
			-- Decodificador
			case num is
				when "0000" =>
					case cont is
						when "00" => seg1 <= "0000001";
						when "01" => seg2 <= "0000001";
						when "10" => seg3 <= "0000001";
						when others => null;
					end case;
				when "0001" =>
					case cont is
						when "00" => seg1 <= "1001111";
						when "01" => seg2 <= "1001111";
						when "10" => seg3 <= "1001111";
						when others => null;
					end case;
				when "0010" =>
					case cont is
						when "00" => seg1 <= "0010010";
						when "01" => seg2 <= "0010010";
						when "10" => seg3 <= "0010010";
						when others => null;
					end case;
				when "0011" =>
					case cont is
						when "00" => seg1 <= "0000110";
						when "01" => seg2 <= "0000110";
						when "10" => seg3 <= "0000110";
						when others => null;
					end case;
				when "0100" =>
					case cont is
						when "00" => seg1 <= "1001100";
						when "01" => seg2 <= "1001100";
						when "10" => seg3 <= "1001100";
						when others => null;
					end case;
				when "0101" =>
					case cont is
						when "00" => seg1 <= "0100100";
						when "01" => seg2 <= "0100100";
						when "10" => seg3 <= "0100100";
						when others => null;
					end case;
				when "0110" =>
					case cont is
						when "00" => seg1 <= "0100000";
						when "01" => seg2 <= "0100000";
						when "10" => seg3 <= "0100000";
						when others => null;
					end case;
				when "0111" =>
					case cont is
						when "00" => seg1 <= "0001111";
						when "01" => seg2 <= "0001111";
						when "10" => seg3 <= "0001111";
						when others => null;
					end case;
				when "1000" =>
					case cont is
						when "00" => seg1 <= "0000000";
						when "01" => seg2 <= "0000000";
						when "10" => seg3 <= "0000000";
						when others => null;
					end case;
				when "1001" =>
					case cont is
						when "00" => seg1 <= "0001100";
						when "01" => seg2 <= "0001100";
						when "10" => seg3 <= "0001100";
						when others => null;
					end case;
				when others =>
					case cont is
						when "00" => seg1 <= "1111110";
						when "01" => seg2 <= "1111110";
						when "10" => seg3 <= "1111110";
						when others => null;
					end case;
			end case;
			-- Seleccionar el display
			case cont is
				when "00" => 
					ans <= "100";
					segs <= seg1;
				when "01" => 
					ans <= "010";
					segs <= seg2;
				when "10" => 
					ans <= "001";
					segs <= seg3;
				when others => 
					ans <= "100";
					segs <= seg1;
			end case;
		end if;
    end process;
	
	seg <= segs;
	an <= ans;

end Behavioral;
