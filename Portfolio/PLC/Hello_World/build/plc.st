TYPE
  LOGLEVEL : (CRITICAL, WARNING, INFO, DEBUG) := INFO;
END_TYPE

FUNCTION_BLOCK LOGGER
  VAR_INPUT
    TRIG : BOOL;
    MSG : STRING;
    LEVEL : LOGLEVEL := INFO;
  END_VAR
  VAR
    TRIG0 : BOOL;
  END_VAR

  IF TRIG AND NOT TRIG0 THEN
  {{
   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  }}
  END_IF;
  TRIG0:=TRIG;
END_FUNCTION_BLOCK


PROGRAM HelloWorld
  VAR
    Set : BOOL;
    Reset : BOOL;
    Hello_World : BOOL;
    Select : INT;
    Mode_1 : BOOL;
    Mode_2 : BOOL;
    Mode_3 : BOOL;
    Mode_4 : BOOL;
    LED : BOOL;
    LED0 : BOOL;
    R_TRIG0 : R_TRIG;
    F_TRIG0 : F_TRIG;
    _TMP_MOVE27_ENO : BOOL;
    _TMP_MOVE27_OUT : INT;
    _TMP_MOVE1_ENO : BOOL;
    _TMP_MOVE1_OUT : INT;
    _TMP_MOVE2_ENO : BOOL;
    _TMP_MOVE2_OUT : INT;
    _TMP_MOVE3_ENO : BOOL;
    _TMP_MOVE3_OUT : INT;
    _TMP_EQ35_OUT : BOOL;
  END_VAR

  IF Set THEN
    Hello_World := TRUE; (*set*)
  END_IF;
  IF Reset THEN
    Hello_World := FALSE; (*reset*)
  END_IF;
  _TMP_MOVE27_OUT := MOVE(EN := Mode_1, IN := 1, ENO => _TMP_MOVE27_ENO);
  IF _TMP_MOVE27_ENO THEN
      Select := _TMP_MOVE27_OUT;
  END_IF;
  _TMP_MOVE1_OUT := MOVE(EN := Mode_2, IN := 2, ENO => _TMP_MOVE1_ENO);
  IF _TMP_MOVE1_ENO THEN
      Select := _TMP_MOVE1_OUT;
  END_IF;
  _TMP_MOVE2_OUT := MOVE(EN := Mode_3, IN := 3, ENO => _TMP_MOVE2_ENO);
  IF _TMP_MOVE2_ENO THEN
      Select := _TMP_MOVE2_OUT;
  END_IF;
  _TMP_MOVE3_OUT := MOVE(EN := Mode_4, IN := 4, ENO => _TMP_MOVE3_ENO);
  IF _TMP_MOVE3_ENO THEN
      Select := _TMP_MOVE3_OUT;
  END_IF;
  _TMP_EQ35_OUT := EQ(Select, 3);
  LED := _TMP_EQ35_OUT;
  R_TRIG0(CLK := _TMP_MOVE27_ENO);
  F_TRIG0(CLK := _TMP_MOVE27_ENO);
  LED0 := F_TRIG0.Q OR R_TRIG0.Q;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : HelloWorld;
  END_RESOURCE
END_CONFIGURATION
