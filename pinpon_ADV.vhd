library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity pinpon_ADV is
    Port ( clk  : in STD_LOGIC;
           rst  : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR (7 downto 0);
           p1   : in STD_LOGIC;
           p2   : in STD_LOGIC);
           --score1: out UNSIGNED (2 downto 0);
           --score2: out UNSIGNED (2 downto 0));
end pinpon_ADV;

architecture Behavioral of pinpon_ADV is
    signal slow_cnt  : unsigned(23 downto 0) := (others => '0');-- 控制速度
    signal tick      : std_logic := '0';
    signal led_reg   : std_logic_vector(7 downto 0);
    signal p1h       : std_logic := '0';
    signal p2h       : std_logic := '0'; 
    signal p1e       : std_logic := '0';
    signal p2e       : std_logic := '0';
    signal s1        : unsigned(2 downto 0) := (others => '0');
    signal s2        : unsigned(2 downto 0) := (others => '0');
    signal flash_cnt : integer range 0 to 5 := 0;-- 計數閃爍次數
    type state_type is (LS, LM, LF, RS, RM, RF);
    signal state : state_type := LS;
begin

clkcheck:process(clk,rst)
begin
    if rst = '0' then
            slow_cnt <= (others => '0');
            tick <= '0';
        elsif rising_edge(clk) then
            slow_cnt <= slow_cnt + 1;
            if slow_cnt = 0 then
                tick <= '1';
            else
                tick <= '0';
            end if;
        end if;
end process clkcheck;

FSM:process(clk,rst,p1,p2)
begin
    if rst = '0' then
            led_reg <= "00000001";
            flash_cnt <= 0;
            state <= LS;
        elsif rising_edge(clk) then
            if tick = '1' then
                case state is
                    when LS =>
                        p2h <= '0';
                        p1h <= '0';
                        flash_cnt <= 0;
                        led_reg <= "00000001";
                        if p2 = '1' then
                            state <= LM;
                        end if;
                    when LM =>
                        if p1e = '1' then
                            state <= RF;
                        else
                            if led_reg = "10000000" then
                                if p1h = '1' then
                                    state <= RM;
                                    p2h <= '0';
                                    p1h <= '0';
                                else
                                    state <= RF;
                                end if;
                            else
                                if p1h = '1' then
                                    state <= RF;
                                end if;
                                led_reg <= std_logic_vector(shift_left(unsigned(led_reg), 1));
                            end if;
                        end if;
                    when LF =>
                        flash_cnt <= flash_cnt + 1;
                        -- 閃爍顯示交替
                        if flash_cnt mod 2 = 0 then
                            led_reg <= "11110000";
                        else
                            led_reg <= "00000000";
                        end if;
                        if flash_cnt = 4 then
                            s1 <= s1 + 1;
                            state <= RS;
                        end if;
                    when RS =>
                        p2h <= '0';
                        p1h <= '0';
                        flash_cnt <= 0;
                        led_reg <= "10000000";
                        if p1 = '1' then
                            state <= RM;
                        end if;
                    when RM =>
                        if p2e = '1' then
                            state <= LF;
                        else
                            if led_reg = "00000001" then
                                if p2h = '1' then
                                    state <= LM;
                                    p2h <= '0';
                                    p1h <= '0';
                                else
                                    state <= LF;
                                end if;
                            else
                                if p2h = '1' then
                                    state <= LF;
                                end if;
                                led_reg <= std_logic_vector(shift_right(unsigned(led_reg), 1));
                            end if;
                        end if;
                    when RF =>
                        flash_cnt <= flash_cnt + 1;
                        -- 閃爍顯示交替
                        if flash_cnt mod 2 = 0 then
                            led_reg <= "00001111";
                        else
                            led_reg <= "00000000";
                        end if;
                        if flash_cnt = 4 then
                            s2 <= s2 + 1;
                            state <= LS;
                        end if;
                end case;
            end if;
        end if;
    if p1 = '1' then
        p1h <= '1';
    end if;
    if p2 = '1' then
        p2h <= '1';
    end if;
end process FSM;

leds   <= led_reg;
--score1 <= s1;
--score2 <= s2;
end Behavioral;
