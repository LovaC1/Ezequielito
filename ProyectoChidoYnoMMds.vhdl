library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Para operaciones aritméticas con std_logic_vector

entity GAL2 is
    Port (
        clk: in  STD_LOGIC;
		d: in STD_LOGIC_VECTOR(2 downto 0);
		n: in STD_LOGIC_VECTOR(3 downto 0);
        q : out  STD_LOGIC_VECTOR(6 downto 0);
		s : out STD_LOGIC_VECTOR(2 downto 0)
      );
end GAL2;

architecture Behavioral of GAL2 is
	signal display: std_logic_vector(6 downto 0);
	signal ndis : std_logic_vector(1 downto 0);
	signal cin: std_logic:= '0';
	signal ss: std_logic_vector(2 downto 0);
begin
	process(clk)
    begin
        if clk'event and clk = '1' then
            ndis(0) <= not ndis(0);
			ndis(1) <= ndis(1) xor ndis(0);
        end if;
    end process;

    process(clk)
    begin
        if clk'event and clk = '1' then
            case n is
                when "0000" => display <= "0000001";  -- 0
                when "0001" => display <= "1001111";  -- 1
                when "0010" => display <= "0010010";  -- 2
                when "0011" => display <= "0000110";  -- 3
                when "0100" => display <= "1001100";  -- 4
                when "0101" => display <= "0100100";  -- 5
                when "0110" => display <= "0100000";  -- 6
                when "0111" => display <= "0001111";  -- 7
                when "1000" => display <= "0000000";  -- 8
                when "1001" => display <= "0000100";  -- 9
                when others => display <= "1111110";  -- Default (apagar)
            end case;
        end if;
    end process;

    process(ndis, d, display)
    begin
        case ndis is
            when "00" => 
                if d = "001" then
                    ss <= "001";
                end if;
            when "01" =>
                if d = "010" then
                    ss <= "010";
                end if;
            when "10" => 
                if d = "100" then
                    ss <= "100";
                end if;
            when others => 
                ss <= "000";
        end case;
    end process;

	q <= display;
	s <= ss;

end Behavioral;
