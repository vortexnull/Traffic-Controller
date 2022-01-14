entity display is

	port(	timer: in integer;
    		color: in bit_vector(1 downto 0);
            lsb_out: out bit_vector(6 downto 0);
            msb_out: out bit_vector(6 downto 0);
            color_out: out bit_vector(6 downto 0)
    );

end;

architecture timerNcolor of display is

begin

  process(timer)
    
        variable lsb: integer;
    
  begin
        lsb := timer mod 16;
      
        case lsb is
            when 0 => lsb_out <= "0000001";  -- 0
            when 1 => lsb_out <= "1001111";  -- 1
            when 2 => lsb_out <= "0010010";  -- 2
            when 3 => lsb_out <= "0000110";  -- 3
            when 4 => lsb_out <= "1001100";  -- 4
            when 5 => lsb_out <= "0100100";  -- 5
            when 6 => lsb_out <= "0100000";  -- 6
            when 7 => lsb_out <= "0001111";  -- 7
            when 8 => lsb_out <= "0000000";  -- 8
            when 9 => lsb_out <= "0000100";  -- 9
            when 10 => lsb_out <= "0000010"; -- a
            when 11 => lsb_out <= "1100000"; -- b
            when 12 => lsb_out <= "0110001"; -- C
            when 13 => lsb_out <= "1000010"; -- d
            when 14 => lsb_out <= "0110000"; -- E
            when 15 => lsb_out <= "0111000"; -- F
            when others => lsb_out <= "1111111";
        end case;
      
	end process;
    
  process(timer)
  
  	    variable msb: integer;
    
  begin
        msb := timer / 16;
      	    
        case msb is
            when 0 => msb_out <= "0000001";  -- 0
            when 1 => msb_out <= "1001111";  -- 1
            when 2 => msb_out <= "0010010";  -- 2
            when 3 => msb_out <= "0000110";  -- 3
            when 4 => msb_out <= "1001100";  -- 4
            when 5 => msb_out <= "0100100";  -- 5
            when 6 => msb_out <= "0100000";  -- 6
            when 7 => msb_out <= "0001111";  -- 7
            when 8 => msb_out <= "0000000";  -- 8
            when 9 => msb_out <= "0000100";  -- 9
            when 10 => msb_out <= "0000010"; -- a
            when 11 => msb_out <= "1100000"; -- b
            when 12 => msb_out <= "0110001"; -- C
            when 13 => msb_out <= "1000010"; -- d
            when 14 => msb_out <= "0110000"; -- E
            when 15 => msb_out <= "0111000"; -- F
            when others => msb_out <= "1111111";
        end case;
      
	end process;
    
    process(color)
    
    begin
        case color is
        	when "01" => color_out <= "1111010";-- r
            when "10" => color_out <= "0100001";-- G
            when "11" => color_out <= "1100010";-- o
    		when others => color_out <= "1111111";
        end case;
    end process;
end;
