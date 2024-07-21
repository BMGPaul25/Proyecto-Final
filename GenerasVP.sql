create or replace NONEDITIONABLE PROCEDURE Genera_VP
AS
    anem NUMBER(3):= 0; 
    poli NUMBER(3):= 0;
    cane NUMBER(5) := 0;
    cpol NUMBER(5) := 0;

    CURSOR BioHemD IS
    SELECT orden, edad, sexo, hematocrito, hemoglobina, glob_rojos, vol_corpuscular_m, 
    hgb_corpuscular_m, c_hgb_corpuscular_m 
    FROM biom_hema_def
    ORDER BY orden;

    CURSOR enfer IS
    SELECT parametro, min_h, max_h, min_m, max_m, min_n, max_n, enfe_men, enfe_may FROM enfermedades; 
BEGIN
    
    FOR bhd IN BioHemD LOOP
       anem := 0;
       poli := 0;
       cane := 0;
       cpol := 0;
       FOR enf IN enfer LOOP
           IF enf.parametro = 'HEMATOCRITO' THEN  
                IF bhd.sexo = 1 AND bhd.edad > 11 THEN
                    IF bhd.hematocrito < enf.min_h THEN
--                        DBMS_OUTPUT.PUT_LINE('Entre por HENATOCRITO sexo 1 y edad > 11 '||bhd.sexo||' '||bhd.hematocrito);
                        anem := 1;
                        cane := cane + 1;
                    ELSE
						IF bhd.hematocrito > enf.max_h THEN
--                            DBMS_OUTPUT.PUT_LINE('Entre por POLIGLOBULIA sexo 1 y edad > 11 '||bhd.sexo||' '||bhd.hematocrito);
							poli := 1;
							cpol := cpol + 1;
						END IF;
					END IF;
				ELSE
					IF bhd.sexo = 0 AND bhd.edad > 11 THEN
						IF bhd.hematocrito < enf.min_m THEN
							anem := 1;
							cane := cane + 1;
						ELSE
							IF bhd.hematocrito > enf.max_m THEN
								poli := 1;
								cpol := cpol + 1;
							END IF;
						END IF;
					ELSE
						IF bhd.edad <= 11 THEN
							IF bhd.hematocrito < enf.min_n THEN
								anem := 1;
								cane := cane + 1;
							ELSE
								IF bhd.hematocrito > enf.max_n THEN
									poli := 1;
									cpol := cpol + 1;
								END IF;
							END IF;
						END IF;
					END IF;
                END IF;	
			END IF;

			IF enf.parametro = 'HEMOGLOBINA' THEN  
				IF bhd.sexo = 1 AND bhd.edad > 11 THEN
					IF bhd.hemoglobina < enf.min_h THEN
--						DBMS_OUTPUT.PUT_LINE('Entre por HEMOGLO sexo 1 y edad > 11');
                        anem := 1;
						cane := cane + 1;
					ELSE
						IF bhd.hemoglobina > enf.max_h THEN
							poli := 1;
							cpol := cpol + 1;
						END IF;
					END IF;
				ELSE
					IF bhd.sexo = 0 AND bhd.edad > 11 THEN
						IF bhd.hemoglobina < enf.min_m THEN
							anem := 1;
							cane := cane + 1;
						ELSE
							IF bhd.hemoglobina > enf.max_m THEN
								poli := 1;
								cpol := cpol + 1;
							END IF;
						END IF;
					ELSE
						IF bhd.edad <= 11 THEN
							IF bhd.hemoglobina < enf.min_n THEN
								anem := 1;
								cane := cane + 1;
							ELSE
								IF bhd.hemoglobina > enf.max_n THEN
									poli := 1;
									cpol := cpol + 1;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;

			IF enf.parametro = 'GLOB_ROJOS' THEN  
				IF bhd.sexo = 1 AND bhd.edad > 11 THEN
					IF bhd.glob_rojos < enf.min_h THEN
						anem := 1;
						cane := cane + 1;
					ELSE
						IF bhd.glob_rojos > enf.max_h THEN
							poli := 1;
							cpol := cpol + 1;
						END IF;
					END IF;
				ELSE
					IF bhd.sexo = 0 AND bhd.edad > 11 THEN
						IF bhd.glob_rojos < enf.min_m THEN
							anem := 1;
							cane := cane + 1;
						ELSE
							IF bhd.glob_rojos > enf.max_m THEN
								poli := 1;
								cpol := cpol + 1;
							END IF;
						END IF;
					ELSE
						IF bhd.edad <= 11 THEN
							IF bhd.glob_rojos < enf.min_n THEN
								anem := 1;
								cane := cane + 1;
							ELSE
								IF bhd.glob_rojos > enf.max_n THEN
									poli := 1;
									cpol := cpol + 1;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;		

			IF enf.parametro = 'VOL_CORPUSCULAR_M' THEN  
				IF bhd.sexo = 1 AND bhd.edad > 11 THEN
					IF bhd.glob_rojos < enf.min_h THEN
						anem := 1;
						cane := cane + 1;
					ELSE
						IF bhd.VOL_CORPUSCULAR_M > enf.max_h THEN
							poli := 1;
							cpol := cpol + 1;
						END IF;
					END IF;
				ELSE
					IF bhd.sexo = 0 AND bhd.edad > 11 THEN
						IF bhd.VOL_CORPUSCULAR_M < enf.min_m THEN
							anem := 1;
							cane := cane + 1;
						ELSE
							IF bhd.VOL_CORPUSCULAR_M > enf.max_m THEN
								poli := 1;
								cpol := cpol + 1;
							END IF;
						END IF;
					ELSE
						IF bhd.edad <= 11 THEN
							IF bhd.VOL_CORPUSCULAR_M < enf.min_n THEN
								anem := 1;
								cane := cane + 1;
							ELSE
								IF bhd.VOL_CORPUSCULAR_M > enf.max_n THEN
									poli := 1;
									cpol := cpol + 1;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;

			IF enf.parametro = 'HGB_CORPUSCULAR_M' THEN  
				IF bhd.sexo = 1 AND bhd.edad > 11 THEN
					IF bhd.HGB_CORPUSCULAR_M < enf.min_h THEN
						anem := 1;
						cane := cane + 1;
					ELSE
						IF bhd.HGB_CORPUSCULAR_M > enf.max_h THEN
							poli := 1;
							cpol := cpol + 1;
						END IF;
					END IF;
				ELSE
					IF bhd.sexo = 0 AND bhd.edad > 11 THEN
						IF bhd.HGB_CORPUSCULAR_M < enf.min_m THEN
							anem := 1;
							cane := cane + 1;
						ELSE
							IF bhd.HGB_CORPUSCULAR_M > enf.max_m THEN
								poli := 1;
								cpol := cpol + 1;
							END IF;
						END IF;
					ELSE
						IF bhd.edad <= 11 THEN
							IF bhd.HGB_CORPUSCULAR_M < enf.min_n THEN
								anem := 1;
								cane := cane + 1;
							ELSE
								IF bhd.HGB_CORPUSCULAR_M > enf.max_n THEN
									poli := 1;
									cpol := cpol + 1;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;

			IF enf.parametro = 'C_HGB_CORPUSCULAR_M' THEN  
				IF bhd.sexo = 1 AND bhd.edad > 11 THEN
					IF bhd.C_HGB_CORPUSCULAR_M < enf.min_h THEN
						anem := 1;
						cane := cane + 1;
					ELSE
						IF bhd.C_HGB_CORPUSCULAR_M > enf.max_h THEN
							poli := 1;
							cpol := cpol + 1;
						END IF;
					END IF;
				ELSE
					IF bhd.sexo = 0 AND bhd.edad > 11 THEN
						IF bhd.C_HGB_CORPUSCULAR_M < enf.min_m THEN
							anem := 1;
							cane := cane + 1;
						ELSE
							IF bhd.C_HGB_CORPUSCULAR_M > enf.max_m THEN
								poli := 1;
								cpol := cpol + 1;
							END IF;
						END IF;
					ELSE
						IF bhd.edad <= 11 THEN
							IF bhd.C_HGB_CORPUSCULAR_M < enf.min_n THEN
								anem := 1;
								cane := cane + 1;
							ELSE
								IF bhd.C_HGB_CORPUSCULAR_M > enf.max_n THEN
									poli := 1;
									cpol := cpol + 1;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;			
		END LOOP;
--        DBMS_OUTPUT.PUT_LINE('los valores son '||cane||' '||cpol);
		UPDATE biom_hema_def SET anemia = anem, poliglobulia = poli, niv_conf_ane = cane, niv_conf_pol = cpol
		WHERE orden = bhd.orden;
    END LOOP;
    COMMIT;
END Genera_VP;