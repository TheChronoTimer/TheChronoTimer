FUNCTION_BLOCK ONS
  VAR_INPUT
    INPUT : BOOL;
  END_VAR
  VAR_OUTPUT
    OUTPUT : BOOL;
  END_VAR
  VAR
    LATCH : BOOL;
  END_VAR

  OUTPUT := NOT(LATCH) AND INPUT;
  IF INPUT THEN
    LATCH := TRUE; (*set*)
  END_IF;
  IF NOT(INPUT) THEN
    LATCH := FALSE; (*reset*)
  END_IF;
END_FUNCTION_BLOCK

PROGRAM ONS_OneShot
  VAR
    ONS0 : ONS;
    INPUT : BOOL;
    OUTPUT : BOOL;
  END_VAR

  ONS0(INPUT := INPUT);
  OUTPUT := ONS0.OUTPUT;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : ONS_OneShot;
  END_RESOURCE
END_CONFIGURATION
