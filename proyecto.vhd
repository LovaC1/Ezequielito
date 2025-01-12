library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Para operaciones aritméticas con std_logic_vector

entity GAL1 is
    Port (
        clk, send, close : in  STD_LOGIC;           
        sw1, sw2, sw3, sw4 : in  STD_LOGIC;
        Lr, Lv : out STD_LOGIC
    );
end GAL1;

architecture Behavioral of GAL1 is
    signal Lrs: std_logic := '1';
    signal psw: std_logic := '0';
    signal comparison_count: std_logic_vector(1 downto 0) := "00"; -- Contador de 2 bits
begin
    process(clk)
    begin
        if CLK'event and CLK = '1' then
            if close = '1' then
                psw <= '0';
                Lrs <= '1';
                comparison_count <= "00"; -- Reinicia el contador cuando se cierra
            end if;

            if send = '1' and comparison_count < "11" then -- Permitir comparación solo si contador < 3
                if sw1 = '0' and sw2 = '1' and sw3 = '1' and sw4 = '0' then
                    psw <= '1';
                end if;
                comparison_count <= std_logic_vector(unsigned(comparison_count) + 1); -- Incrementa el contador
            end if;

            if psw = '1' then
                Lrs <= '0';
            end if;
        end if;
    end process;
    
    LR <= LRs;
    LV <= not LRs;
end Behavioral;
