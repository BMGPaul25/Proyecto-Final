create or replace NONEDITIONABLE PROCEDURE Transforma_Data
AS
    poc                 INTEGER;
    poe                 INTEGER;
    edad                INTEGER;
    t_edad              VARCHAR2(6);
    poc1                INTEGER;
    poc2                INTEGER;
    dato                NUMBER(10,4);
    parametro           VARCHAR2(30);
    HEMA                NUMBER(10,4);
    HEMO                NUMBER(10,4);
    PLAQ                NUMBER(10,4);
    GLOB_B              NUMBER(10,4);
    NEUT                NUMBER(10,4);
    LINF                NUMBER(10,4);
    NEUT_P              NUMBER(10,4);
    LINF_P              NUMBER(10,4);
    GLOB_R              NUMBER(10,4);
    VOL_C               NUMBER(10,4);
    HGB_C               NUMBER(10,4);
    C_HGB               NUMBER(10,4);
    RDW_CV              NUMBER(10,4);
    MID_P               NUMBER(10,4);
    MID                 NUMBER(10,4);
    MPV                 NUMBER(10,4);
    PDW                 NUMBER(10,4);
    PCT                 NUMBER(10,4);
    RDW_SD              NUMBER(10,4);
    SEDI                NUMBER(10,4);
    ord                 biom_hema_def.orden%TYPE;
    ced                 biom_hema_def.cedula%TYPE;
    pac                 biom_hema_def.paciente%TYPE;
    eda                 biom_hema_def.edad%TYPE;
    sex                 biom_hema_def.sexo%TYPE;
    fing                biom_hema_def.fecha_ingreso%TYPE;

    CURSOR lorden IS 
    SELECT orden FROM biom_hema GROUP BY orden ORDER BY orden;
--    SELECT orden FROM biom_hema WHERE orden = '80617' GROUP BY orden ORDER BY orden;    
    CURSOR torden(ordenorg IN VARCHAR2) IS
    SELECT orden, cedula, paciente, edad, sexo, fecha_ingreso, resultado FROM biom_hema
    WHERE Orden = ordenorg
    ORDER BY resultado;
BEGIN
    FOR regun IN lorden LOOP
        FOR regbh IN torden(regun.orden) LOOP
            ord:=regbh.orden;
            ced:=regbh.cedula;
            pac:=regbh.paciente;
            SELECT INSTR(regbh.edad,' ') INTO poc FROM dual;
            poe := poc-1; 
            SELECT substr(regbh.edad,1,poe) INTO edad FROM dual;
            poe := poc+1;
            SELECT substr(regbh.edad,poe,5) INTO t_edad FROM dual;
            IF t_edad = 'MESES' THEN
                eda := edad/12;
            ELSE
                eda := edad;
            END IF;
--            eda:=regbh.edad;
            IF regbh.sexo='M' THEN
                sex:=1;
            ELSE
                sex:=0;
            END IF;
            fing:=regbh.fecha_ingreso;
            SELECT instr(regbh.resultado,':') INTO poc FROM dual;
            poc1 := poc-1;
            SELECT substr(regbh.resultado,1,poc1) INTO parametro FROM dual;
            poc2 := poc+2;
            DBMS_OUTPUT.PUT_LINE('PARAMETRO '||parametro||' --- '||poc2);
            IF parametro = 'SEDIMENTACION' AND SUBSTR(regbh.resultado,poc2,6) = '.'  THEN
                dato := null;
            ELSE
                SELECT REPLACE(SUBSTR(regbh.resultado,poc2,6),'.',',') INTO dato FROM dual;
                DBMS_OUTPUT.PUT_LINE('DATOS ----- '||dato||' --- '||poc2);
            END IF;

            IF parametro = 'CONC. HGB CORPUSCULAR MEDIA' THEN
                C_HGB := dato;
            END IF;
            IF parametro = 'GLOBULOS BLANCOS' THEN
                GLOB_B := dato;
            END IF;
            IF parametro = 'HEMATOCRITO' THEN
                HEMA := dato;
            END IF;
            IF parametro = 'HEMOGLOBINA' THEN
                HEMO := dato;
            END IF;
            IF parametro = 'HGB CORPUSCULAR MEDIA' THEN
                HGB_C := dato;
            END IF;
            IF parametro = 'LINFOCITOS %' THEN
                LINF_P := dato;
            END IF;
            IF parametro = 'LINFOCITOS' THEN
                LINF := dato;
            END IF;
            IF parametro = 'MID %' THEN
                MID_P := dato;
            END IF;
            IF parametro = 'MID' THEN
                MID := dato;
            END IF;
            IF parametro = 'MPV' THEN
                MPV := dato;
            END IF;
            IF parametro = 'NEUTROFILOS %' THEN
                NEUT_P := dato;
            END IF;
            IF parametro = 'NEUTROFILOS' THEN
                NEUT := dato;
            END IF;
            IF parametro = 'PCT' THEN
                PCT := dato;
            END IF;
            IF parametro = 'PDW' THEN
                PDW := dato;
            END IF;
            IF parametro = 'PLAQUETAS' THEN
                PLAQ := dato;
            END IF;
            IF parametro = 'RDW CV' THEN
                RDW_CV := dato;
            END IF;
            IF parametro = 'RDW SD' THEN
                RDW_SD := dato;
            END IF;
            IF parametro = 'RECUENTO DE GLOBULOS ROJOS' THEN
                GLOB_R := dato;
            END IF;
--            IF parametro = 'SEDIMENTACION' THEN
--                SEDI := dato;
--            END IF;
            IF parametro = 'VOL. CORPUSCULAR MEDIO' THEN
                VOL_C := dato;
            END IF;
            SEDI := null;

        END LOOP;
        DBMS_OUTPUT.PUT_LINE(ord||' '||ced||' '||pac||' '||eda||' '||sex||' '||fing);
        DBMS_OUTPUT.PUT_LINE(C_HGB||' '||GLOB_B||' '||HEMA||' '||HEMO||' '||HGB_C||' '||LINF_P||' '||LINF||' '||MID_P||' '||MID||' '||MPV);
        DBMS_OUTPUT.PUT_LINE(NEUT_P||' '||NEUT||' '||PCT||' '||PDW||' '||PLAQ||' '||RDW_CV||' '||RDW_SD||' '||GLOB_R||' '||SEDI||' '||VOL_C);
        INSERT INTO BIOM_HEMA_DEF 
        VALUES (ord, ced, pac, eda, sex, fing, HEMA, HEMO, PLAQ, GLOB_B, NEUT, LINF, NEUT_P, LINF_P,
        GLOB_R, VOL_C, HGB_C, C_HGB, RDW_CV, MID_P, MID, MPV, PDW, PCT, RDW_SD, SEDI);

    END LOOP;
    COMMIT;
END Transforma_DATA;