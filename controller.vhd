entity controller is
	
    generic(	Tcyc: integer;
    			Tor: integer;
                tau: integer
    );
    
    port(	clk: in bit;
    		emgBit: in bit;
            pedBit: in bit;
    		Tg1in: in integer;
            Tg2in: in integer;
            Tg3in: in integer;
            Tg4in: in integer;
            timerN: out integer:= (Tcyc - 4 * Tor) / 4;
            timerE: out integer:= Tcyc / 4;
            timerS: out integer:= 2 * Tcyc / 4;
            timerW: out integer:= 3 * Tcyc / 4;
            colorN: out bit_vector(1 downto 0):= "01";
            colorE: out bit_vector(1 downto 0):= "01";
            colorS: out bit_vector(1 downto 0):= "01";
            colorW: out bit_vector(1 downto 0):= "01" 
    );
    
end;

architecture ctrl_traffic of controller is

	signal emgOn: bit:= '0';
    signal emgOff: bit:= '0';
    signal pedOn: bit:= '0';
    signal pedOff: bit:= '0';
    signal Tg1: integer:= (Tcyc - 4 * Tor) / 4;
    signal Tg2: integer:= (Tcyc - 4 * Tor) / 4;
    signal Tg3: integer:= (Tcyc - 4 * Tor) / 4;
    signal Tg4: integer:= (Tcyc - 4 * Tor) / 4;

begin
	
    process
    	
        variable mod1: integer;
        variable mod2: integer;
        variable mod3: integer;
        variable tmp1: integer;
        variable tmp2: integer;
        variable tmp3: integer;
        
    begin
        mod1 := Tg1in mod tau;
        mod2 := Tg2in mod tau;
        mod3 := Tg3in mod tau;
    	
        if mod1 <= tau / 2 then tmp1 := Tg1in - mod1;
        else tmp1 := Tg1in + tau - mod1;
        end if;
        
        if mod2 <= tau / 2 then tmp2 := Tg2in - mod2;
        else tmp2 := Tg2in + tau - mod2;
        end if;
        
        if mod3 <= tau / 2 then tmp3 := Tg3in - mod3;
        else tmp3 := Tg3in + tau - mod3;
        end if;
        
        Tg1 <= tmp1;
        Tg2 <= tmp2;
        Tg3 <= tmp3;
        Tg4 <= Tcyc - 4 * Tor - tmp1 - tmp2 - tmp3;
        
        wait on Tg1in, Tg2in, Tg3in, Tg4in;
    end process;
	
    process
    
    begin
    	wait on emgBit, emgOff;
        
        if emgBit = '1' then emgOn <= '1';
        end if;
        if emgOff = '1' then emgOn <= '0';
        end if;

    end process;
    
    process
    
    begin
    	wait on pedBit, pedOff;
    
    	if pedBit = '1' then pedOn <= '1';
        end if;
        if pedOff = '1' then pedOn <= '0';
        end if;
        
    end process;
    
	process
	
    	variable VarTN: integer;
        variable varTE: integer:= Tcyc / 4;
        variable varTS: integer:= (2 * Tcyc) / 4;
        variable varTW: integer:= (3 * Tcyc) / 4;
        
   	begin
        
        colorN <= "10";
        varTN := Tg1;
        
		while varTN > 0 loop
        	timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;
            
            exit when emgOn = '1';
            wait until clk'event and clk = '1';
            
            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;    
   		
        colorN <= "11";
        
        varTE := varTE - varTN;
        varTS := varTS - varTN;
        varTW := varTW - varTN;
        varTN := Tor;
        
        while varTN > 0 loop
        	timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;
            
            wait until clk'event and clk = '1';
            
            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;
        
        colorN <= "01";
        
        if emgOn = '1' then
        	emgOff <= '1';
            
        	varTN := 10;
            varTE := varTE + 10;
            varTS := varTS + 10;
            varTW := varTW + 10;
            
        	while varTN > 0 loop
            	timerN <= varTN;
            	timerE <= varTE;
            	timerS <= varTS;
            	timerW <= varTW;
            
            	wait until clk'event and clk = '1';
            
            	varTN := varTN - 1;
            	varTE := varTE - 1;
            	varTS := varTS - 1;
            	varTW := varTW - 1;
            end loop;
        end if;
        
        if pedOn = '1' then
        	pedOff <= '1';
            
        	varTN := 10;
            varTE := varTE + 10;
            varTS := varTS + 10;
            varTW := varTW + 10;
            
        	while varTN > 0 loop
            	timerN <= varTN;
            	timerE <= varTE;
            	timerS <= varTS;
            	timerW <= varTW;
            
            	wait until clk'event and clk = '1';
            
            	varTN := varTN - 1;
            	varTE := varTE - 1;
            	varTS := varTS - 1;
            	varTW := varTW - 1;
            end loop;
        end if;
        
        emgOff <= '0';
        pedOff <= '0';
        
        varTN := Tcyc - Tor - Tg1;
        
       	colorE <= "10";
        varTE := Tg2;
        
        while varTE > 0 loop
        	timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;
            
            exit when emgOn = '1';
            wait until clk'event and clk = '1';
            
            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;
        
        colorE <= "11";
        
        varTN := varTN - varTE;
        varTS := varTS - varTE;
        varTW := varTW - varTE;
        varTE := Tor;
        
        while varTE > 0 loop
        	timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;
            
            wait until clk'event and clk = '1';
            
            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;
        
        colorE <= "01";
        
        if emgOn = '1' then
        	emgOff <= '1';
            
        	varTE := 10;
            varTN := varTN + 10;
            varTS := varTS + 10;
            varTW := varTW + 10;
            
        	while varTE > 0 loop
            	timerN <= varTN;
            	timerE <= varTE;
            	timerS <= varTS;
            	timerW <= varTW;
            
            	wait until clk'event and clk = '1';
            
            	varTN := varTN - 1;
            	varTE := varTE - 1;
            	varTS := varTS - 1;
            	varTW := varTW - 1;
            end loop;
        end if;
        
        if pedOn = '1' then
        	pedOff <= '1';
            
        	varTE := 10;
            varTN := varTN + 10;
            varTS := varTS + 10;
            varTW := varTW + 10;
            
        	while varTE > 0 loop
                timerN <= varTN;
                timerE <= varTE;
                timerS <= varTS;
                timerW <= varTW;

                wait until clk'event and clk = '1';

                varTN := varTN - 1;
                varTE := varTE - 1;
                varTS := varTS - 1;
                varTW := varTW - 1;
            end loop;
        end if;
        
        emgOff <= '0';
        pedOff <= '0';
        
        varTE := Tcyc - Tor - Tg2;
        
        colorS <= "10";
        varTS := Tg3;

        while varTS > 0 loop
            timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;

            exit when emgOn = '1';
            wait until clk'event and clk = '1';

            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;

        colorS <= "11";

        varTN := varTN - varTS;
        varTE := varTE - varTS;
        varTW := varTW - varTS;
        varTS := Tor;

        while varTS > 0 loop
            timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;

            wait until clk'event and clk = '1';

            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;

        colorS <= "01";

        if emgOn = '1' then
        	emgOff <= '1';
            
            varTS := 10;
            varTN := varTN + 10;
            varTE := varTE + 10;
            varTW := varTW + 10;

          	while varTS > 0 loop
                timerN <= varTN;
                timerE <= varTE;
                timerS <= varTS;
                timerW <= varTW;

                wait until clk'event and clk = '1';

                varTN := varTN - 1;
                varTE := varTE - 1;
                varTS := varTS - 1;
                varTW := varTW - 1;
            end loop;
        end if;

        if pedOn = '1' then
        	pedOff <= '1';
            
            varTS := 10;
            varTN := varTN + 10;
            varTE := varTE + 10;
            varTW := varTW + 10;

          	while varTS > 0 loop
                timerN <= varTN;
                timerE <= varTE;
                timerS <= varTS;
                timerW <= varTW;

                wait until clk'event and clk = '1';

                varTN := varTN - 1;
                varTE := varTE - 1;
                varTS := varTS - 1;
                varTW := varTW - 1;
            end loop;
        end if;

        emgOff <= '0';
        pedOff <= '0';

        varTS := Tcyc - Tor - Tg3;
        
        colorW <= "10";
        varTW := Tg4;

        while varTW > 0 loop
            timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;

            exit when emgOn = '1';
            wait until clk'event and clk = '1';

            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;

        colorW <= "11";

        varTN := varTN - varTW;
        varTE := varTE - varTW;
        varTS := varTS - varTW;
        varTW := Tor;

        while varTW > 0 loop
            timerN <= varTN;
            timerE <= varTE;
            timerS <= varTS;
            timerW <= varTW;

            wait until clk'event and clk = '1';

            varTN := varTN - 1;
            varTE := varTE - 1;
            varTS := varTS - 1;
            varTW := varTW - 1;
        end loop;

        colorW <= "01";

        if emgOn = '1' then
        	emgOff <= '1';
            
            varTW := 10;
            varTN := varTN + 10;
            varTE := varTE + 10;
            varTS := varTS + 10;

          	while varTW > 0 loop
                timerN <= varTN;
                timerE <= varTE;
                timerS <= varTS;
                timerW <= varTW;

                wait until clk'event and clk = '1';

                varTN := varTN - 1;
                varTE := varTE - 1;
                varTS := varTS - 1;
                varTW := varTW - 1;
			end loop;
        end if;

        if pedOn = '1' then
        	pedOff <= '1';
            
            varTW := 10;
            varTN := varTN + 10;
            varTE := varTE + 10;
            varTS := varTS + 10;

          	while varTW > 0 loop
                timerN <= varTN;
                timerE <= varTE;
                timerS <= varTS;
                timerW <= varTW;

                wait until clk'event and clk = '1';

                varTN := varTN - 1;
                varTE := varTE - 1;
                varTS := varTS - 1;
                varTW := varTW - 1;
          	end loop;
        end if;

        emgOff <= '0';
        pedOff <= '0';

        varTW := Tcyc - Tor - Tg4;
        
   	end process;
    
end;