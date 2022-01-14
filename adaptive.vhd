entity adaptation is

	generic(	Tcyc: integer;
    			Tor: integer;
    			beta: integer;
                tau: integer
    );
    
    port( 	N1: in integer;
            N2: in integer;
            N3: in integer;
            N4: in integer;
            Tg1: out integer:= (Tcyc - 4 * Tor) / 4;
            Tg2: out integer:= (Tcyc - 4 * Tor) / 4;
            Tg3: out integer:= (Tcyc - 4 * Tor) / 4;
            Tg4: out integer:= (Tcyc - 4 * Tor) / 4
    );
    
end;

architecture adaptive_unit of adaptation is

begin
    
    process
    	variable t: integer:= (Tcyc - 4 * Tor) / 4;
    begin
    	wait on N4;
        
        if tau > (4 * t +  beta * (4 * N1 - (N1 + N2 + N3 + N4))) / 4 then
        	Tg1 <= t;
        else
        	t := (4 * t +  beta * (4 * N1 - (N1 + N2 + N3 + N4))) / 4;
            Tg1 <= t;
        end if;    
    end process;
    
    process
    	variable t: integer:= (Tcyc - 4 * Tor) / 4;
    begin
    	wait on N4;

        if tau > (4 * t +  beta * (4 * N2 - (N1 + N2 + N3 + N4))) / 4 then
        	Tg2 <= t;
        else
        	t := (4 * t +  beta * (4 * N2 - (N1 + N2 + N3 + N4))) / 4;
            Tg2 <= t;
        end if;    
    end process;
    
    process
    	variable t: integer:= (Tcyc - 4 * Tor) / 4;
    begin
    	wait on N4;

        if tau > (4 * t +  beta * (4 * N3 - (N1 + N2 + N3 + N4))) / 4 then
        	Tg3 <= t;
        else
        	t := (4 * t +  beta * (4 * N3 - (N1 + N2 + N3 + N4))) / 4;
            Tg3 <= t;
        end if;    
    end process;
    
    process
    	variable t: integer:= (Tcyc - 4 * Tor) / 4;
    begin
    	wait on N4;

        if tau > (4 * t +  beta * (4 * N4 - (N1 + N2 + N3 + N4))) / 4 then
        	Tg4 <= t;
        else
        	t := (4 * t +  beta * (4 * N4 - (N1 + N2 + N3 + N4))) / 4;
            Tg4 <= t;
        end if;  
    end process;
    
end;