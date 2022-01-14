entity system_tb is
end;

architecture bench of system_tb is

  component system
      generic(	Tcyc: integer:= 200;
      			    Tor: integer:= 10;
                beta: integer:= 1;
                tau: integer:= 10;
        		    k: integer:= 50          
      );
      port(	  clk: in bit;
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
  end component;

  signal clk: bit;
  signal emgBit: bit;
  signal pedBit: bit;
  signal N1: integer;
  signal N2: integer;
  signal N3: integer;
  signal N4: integer;
  signal LSBtimerN: bit_vector(6 downto 0);
  signal LSBtimerE: bit_vector(6 downto 0);
  signal LSBtimerS: bit_vector(6 downto 0);
  signal LSBtimerW: bit_vector(6 downto 0);
  signal MSBtimerN: bit_vector(6 downto 0);
  signal MSBtimerE: bit_vector(6 downto 0);
  signal MSBtimerS: bit_vector(6 downto 0);
  signal MSBtimerW: bit_vector(6 downto 0);
  signal colorN: bit_vector(6 downto 0);
  signal colorE: bit_vector(6 downto 0);
  signal colorS: bit_vector(6 downto 0);
  signal colorW: bit_vector(6 downto 0);
  
  constant clock_period: time := 1 sec;
  signal stop_the_clock: boolean;

begin

  uut: system port map (    clk       => clk,
                            emgBit    => emgBit,
                            pedBit    => pedBit,
                            N1        => N1,
                            N2        => N2,
                            N3        => N3,
                            N4        => N4,
                            LSBtimerN => LSBtimerN,
                            LSBtimerE => LSBtimerE,
                            LSBtimerS => LSBtimerS,
                            LSBtimerW => LSBtimerW,
                            MSBtimerN => MSBtimerN,
                            MSBtimerE => MSBtimerE,
                            MSBtimerS => MSBtimerS,
                            MSBtimerW => MSBtimerW,
                            colorN    => colorN,
                            colorE    => colorE,
                            colorS    => colorS,
                            colorW    => colorW );

  stimulus: process
  begin
  
    emgBit <= '0', '1' after 55 sec, '0' after 62 sec;
    pedBit <= '0', '1' after 10 sec, '0' after 11 sec;
    
    N1 <= 10,
    	  12 after 15 sec,
        14 after 215 sec,
        16 after 415 sec,
        18 after 615 sec,
        20 after 815 sec,
        22 after 1015 sec,
        24 after 1215 sec,
        22 after 1415 sec,
        20 after 1615 sec,
        18 after 1815 sec,
        16 after 2015 sec;
        
    N2 <= 20,
        18 after 25 sec,
        16 after 225 sec,
        14 after 425 sec,
        12 after 625 sec,
        10 after 825 sec,
        5 after 1025 sec,
        6 after 1225 sec,
        8 after 1425 sec,
        10 after 1625 sec,
        12 after 1825 sec,
        14 after 2025 sec;
    	
    N3 <= 15,
    	  17 after 35 sec,
        19 after 235 sec,
        21 after 435 sec,
        23 after 635 sec,
        25 after 835 sec,
        27 after 1035 sec,
        25 after 1235 sec,
        23 after 1435 sec,
        21 after 1635 sec,
        19 after 1835 sec,
        17 after 2035 sec;
   
    N4 <= 25,
    	  23 after 45 sec,
        21 after 245 sec,
        19 after 445 sec,
        17 after 645 sec,
        15 after 845 sec,
        13 after 1045 sec,
        11 after 1245 sec,
        13 after 1445 sec,
        15 after 1645 sec,
        17 after 1845 sec,
        19 after 2045 sec;
    
    wait for 2200 sec;
	  stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  
  begin
  
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
    
  end process; 
end;