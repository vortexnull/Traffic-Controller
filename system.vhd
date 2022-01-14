entity system is
    
    generic(	Tcyc: integer:= 200;
    			Tor: integer:= 10;
                beta: integer:= 1;
                tau: integer:= 10;
      			k: integer:= 50          
    );
    
    port(	clk: in bit;
    		emgBit: in bit;
            pedBit: in bit;
            N1: in integer;
            N2: in integer;
            N3: in integer;
            N4: in integer;
            LSBtimerN: out bit_vector(6 downto 0);
            LSBtimerE: out bit_vector(6 downto 0);
            LSBtimerS: out bit_vector(6 downto 0);
            LSBtimerW: out bit_vector(6 downto 0);
            MSBtimerN: out bit_vector(6 downto 0);
            MSBtimerE: out bit_vector(6 downto 0);
            MSBtimerS: out bit_vector(6 downto 0);
            MSBtimerW: out bit_vector(6 downto 0);
            colorN: out bit_vector(6 downto 0);
            colorE: out bit_vector(6 downto 0);
            colorS: out bit_vector(6 downto 0);
            colorW: out bit_vector(6 downto 0)
    );
end;

architecture traffic of system is

	component controller
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
                timerN: out integer;
                timerE: out integer;
                timerS: out integer;
                timerW: out integer;
                colorN: out bit_vector(1 downto 0);
                colorE: out bit_vector(1 downto 0);
                colorS: out bit_vector(1 downto 0);
                colorW: out bit_vector(1 downto 0) 
    );
    end component;
    
    component display
    	port(	timer: in integer;
        		color: in bit_vector(1 downto 0);
                lsb_out: out bit_vector(6 downto 0);
            	msb_out: out bit_vector(6 downto 0);
            	color_out: out bit_vector(6 downto 0)
        );
    end component;
    
    component sensor
    	generic(	k: integer
        );

        port(	N: in integer;
        		color: in bit_vector(1 downto 0);
                avgN: out integer
        );
    end component;
    
    component adaptation
    	generic(	Tcyc: integer;
        			Tor: integer;
        			beta: integer;
        			tau: integer
        );

        port(	N1: in integer;
        		N2: in integer;
                N3: in integer;
                N4: in integer;
                Tg1: out integer;
                Tg2: out integer;
                Tg3: out integer;
                Tg4: out integer
        );
	end component;
    
    signal avgN1: integer;
    signal avgN2: integer;
    signal avgN3: integer;
    signal avgN4: integer;
    signal tmpTg1: integer;
    signal tmpTg2: integer;
    signal tmpTg3: integer;
    signal tmpTg4: integer;
    signal tmpT1: integer;
    signal tmpT2: integer;
    signal tmpT3: integer;
    signal tmpT4: integer;
    signal tmpC1: bit_vector(1 downto 0);
    signal tmpC2: bit_vector(1 downto 0);
    signal tmpC3: bit_vector(1 downto 0);
    signal tmpC4: bit_vector(1 downto 0);
    
begin
	
    uc: controller 	generic map (	Tcyc => Tcyc,
    								Tor => Tor,
                                    tau => tau )
                   	port map (	clk => clk,
                                emgBit => emgBit,
                                pedBit => pedBit,
                                Tg1in => tmpTg1,
                                Tg2in => tmpTg2,
                                Tg3in => tmpTg3,
                                Tg4in => tmpTg4,
                                timerN => tmpT1,
                                timerE => tmpT2,
                                timerS => tmpT3,
                                timerW => tmpT4,
                                colorN => tmpC1,
                                colorE => tmpC2,
                                colorS => tmpC3,
                                colorW => tmpC4);
    
    dN: display	port map (	timer => tmpT1,
    						color => tmpC1,
                            lsb_out => LSBtimerN,
                            msb_out => MSBtimerN,
                            color_out => colorN);
    
    dE: display	port map (	timer => tmpT2,
    						color => tmpC2,
                            lsb_out => LSBtimerE,
                            msb_out => MSBtimerE,
                            color_out => colorE);
    
    dS: display	port map (	timer => tmpT3,
    						color => tmpC3,
                            lsb_out => LSBtimerS,
                            msb_out => MSBtimerS,
                            color_out => colorS);
    
    dW: display	port map (	timer => tmpT4,
    					    color => tmpC4,
                            lsb_out => LSBtimerW,
                            msb_out => MSBtimerW,
                            color_out => colorW);

    sN: sensor 	generic map (	k => k )
    			port map (	N => N1,
                			color => tmpC1,
                            avgN => avgN1 );		

    sE: sensor 	generic map (	k => k )
    			port map (	N => N2,
                			color => tmpC2,
                            avgN => avgN2 );
                            
    sS: sensor 	generic map (	k => k )
    			port map (	N => N3,
                			color => tmpC3,
                            avgN => avgN3 );   
                            
    sW: sensor 	generic map (	k => k )
    			port map (	N => N4,
                			color => tmpC4,
                            avgN => avgN4 ); 
	
    ua: adaptation 	generic map (	Tcyc => Tcyc,
    								Tor => Tor,
    								beta => beta,
    								tau => tau )
                   	port map (	N1 => avgN1,
                    			N2 => avgN2,
                                N3 => avgN3,
                                N4 => avgN4,
                                Tg1 => tmpTg1,
                                Tg2 => tmpTg2,
                                Tg3 => tmpTg3,
                                Tg4 => tmpTg4 );
                                
end;