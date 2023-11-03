LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Minuman_Otomatis IS
	PORT(stokbahan, mulai, teh, kopi, selesai, reset, clock		              : IN STD_LOGIC;
		menuangkopi, menuangteh, jenisminuman, bersiap, kurangbahan			  : OUT STD_LOGIC);
				
END Minuman_Otomatis;

ARCHITECTURE Cara_Kerja_Minuman_Otomatis OF Minuman_Otomatis IS
	TYPE state_type IS (standby, pilihminuman, jenisteh, jeniskopi, stop);
	SIGNAL state, next_state : state_type :=standby;
BEGIN
    PROCESS (state, stokbahan, mulai, teh, kopi, selesai, reset)
	BEGIN
		CASE state IS
			WHEN standby =>
				menuangkopi <= '0'; menuangteh <= '0'; jenisminuman<= '0'; 
				bersiap <= '1'; kurangbahan <= '0';
				IF rising_edge(mulai) THEN next_state <= pilihminuman;
					ELSIF rising_edge(mulai) THEN next_state <= pilihminuman;
					ELSIF rising_edge(stokbahan) THEN next_state <= stop;
					ELSE next_state <= standby;
				END IF;
			WHEN pilihminuman =>
				menuangkopi <= '0'; menuangteh <= '0'; jenisminuman<= '1'; 
				bersiap <= '0'; kurangbahan <= '0';
				IF rising_edge(teh) THEN next_state <= jenisteh;
					ELSIF rising_edge(kopi) THEN next_state <= jeniskopi;
					ELSIF rising_edge(reset) THEN next_state <= standby;
					ELSE next_state <= pilihminuman;
				END IF;
			WHEN jeniskopi =>
				menuangkopi <= '1'; menuangteh <= '0'; jenisminuman<= '0'; 
				bersiap <= '0'; kurangbahan <= '0';
				next_state <= standby;
			WHEN jenisteh =>
				menuangkopi <= '0'; menuangteh <= '1'; jenisminuman<= '0'; 
				bersiap <= '0'; kurangbahan <= '0';
				next_state <= standby;
			WHEN stop =>
				menuangkopi <= '0'; menuangteh <= '0'; jenisminuman<= '0'; 
				bersiap <= '0'; kurangbahan <= '1';
				IF falling_edge(stokbahan) THEN next_state <= standby;
					ELSE next_state <= stop;
				END IF;
			WHEN others => null;
		END CASE;
	END PROCESS;
	
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			state <= next_state;
		END IF;
	END PROCESS;
	
END Cara_Kerja_Minuman_Otomatis;