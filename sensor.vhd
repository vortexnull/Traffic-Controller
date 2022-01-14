entity sensor is

	generic(	k : integer
	);
    
    	port(	N: in integer;
    			color: in bit_vector(1 downto 0);
            	avgN: out integer:= 0
    	);
    
end;

architecture vehilce_sensor of sensor is
    
begin
	
    process
    	variable k1: integer:= 0;
    	variable acc: integer:= 0;
    begin
    	wait until color'last_value = "01" and color'event
        -- in case green is skipped completely due to emergency
        			and (color = "10" or color = "11");
    	acc := acc + N;
    
    	if k1 = k - 1 then
    		avgN <= acc / k;
            acc := 0;
        end if;
    
    	k1 := (k1 + 1) mod k;
    end process;
    
end;
    