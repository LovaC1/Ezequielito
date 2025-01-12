-- filepath: /Users/jonathanvazquez/Documents/Programacion/VSCode/Proyecto fdd/Ezequielito/proyecto.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Proyecto is
    Port (
        clk : in std_logic;
        cerrar : in std_logic;
        enviar : in std_logic;
        sw : in std_logic_vector(3 downto 0);
        Lr : out std_logic;
        Lv : out std_logic
    );
end Proyecto;

architecture Comportamental of Proyecto is
    signal Lrs : std_logic := '1';
    signal psw : std_logic := '0';
    signal contador_comparacion : std_logic_vector(1 downto 0) := "00";
    signal comparacion_actual : integer range 0 to 3 := 0;
    constant contraseña1 : std_logic_vector(3 downto 0) := "0001";
    constant contraseña2 : std_logic_vector(3 downto 0) := "0010";
    constant contraseña3 : std_logic_vector(3 downto 0) := "0011";
begin
    process(clk)
    begin
        if clk'event and clk = '1' then
            if cerrar = '1' then
                psw <= '0';
                Lrs <= '1';
                contador_comparacion <= (others => '0');
                comparacion_actual <= 0; 
            elsif enviar = '1' then
                if comparacion_actual = 0 and sw = contraseña1 then
                    psw <= '1';
                    comparacion_actual <= comparacion_actual + 1;

                elsif comparacion_actual = 1 and sw = contraseña2 then
                    psw <= '1';
                    comparacion_actual <= comparacion_actual + 1;

                elsif comparacion_actual = 2 and sw = contraseña3 then
                    psw <= '1';
                    comparacion_actual <= 0;  
                else
                    psw <= '0';
                end if;
            end if;

            if psw = '1' then
                Lrs <= '0';
            end if;
        end if;
    end process;

    Lr <= Lrs;
    Lv <= not Lrs;
end Comportamental;
