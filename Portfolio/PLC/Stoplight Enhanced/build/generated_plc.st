FUNCTION_BLOCK TFF
  VAR_INPUT
    INPUT : BOOL;
  END_VAR
  VAR
    LATCH : BOOL;
  END_VAR
  VAR_OUTPUT
    OUTPUT : BOOL;
  END_VAR

  LATCH := INPUT;
  OUTPUT := NOT(OUTPUT) AND LATCH OR OUTPUT AND NOT(LATCH);
END_FUNCTION_BLOCK

FUNCTION_BLOCK Lights
  VAR_INPUT
    INPUT : BOOL;
  END_VAR
  VAR_OUTPUT
    O_G : BOOL;
    O_Y : BOOL;
    O_R : BOOL;
  END_VAR
  VAR_INPUT
    STOP_TIME : DINT;
    EXT_CTER : DINT;
    EXT_STOP_TIME : DINT;
    DUAL_Y : BOOL;
  END_VAR
  VAR
    DUAL_Y_CTER : BOOL;
    R_TRIG0 : R_TRIG;
    TFF0 : TFF;
    _TMP_SUB72_OUT : DINT;
    _TMP_GE75_OUT : BOOL;
    _TMP_NOT80_OUT : BOOL;
    _TMP_AND1_OUT : BOOL;
    _TMP_AND4_OUT : BOOL;
  END_VAR

  O_G := NOT(O_Y) AND NOT(O_R) AND INPUT AND TRUE;
  O_R := NOT(INPUT) AND TRUE;
  _TMP_SUB72_OUT := SUB(EXT_STOP_TIME, EXT_CTER);
  _TMP_GE75_OUT := GE(_TMP_SUB72_OUT, STOP_TIME);
  _TMP_NOT80_OUT := NOT(_TMP_GE75_OUT);
  _TMP_AND1_OUT := AND(INPUT AND TRUE, _TMP_NOT80_OUT);
  _TMP_AND4_OUT := AND(_TMP_AND1_OUT, NOT(DUAL_Y_CTER));
  O_Y := _TMP_AND4_OUT;
  R_TRIG0(CLK := DUAL_Y AND _TMP_AND1_OUT);
  TFF0(INPUT := R_TRIG0.Q);
  DUAL_Y_CTER := TFF0.OUTPUT;
END_FUNCTION_BLOCK

PROGRAM Stoplight_Enhanced
  VAR
    TIMER : BOOL;
    COUNTER : DINT;
    STOPLIGHT_STOP_TIME : DINT := 200;
    YELLOW_STOP_TIME : DINT := 40;
    STATE : DINT;
    A1 : BOOL;
    A2 : BOOL;
    AP : BOOL;
    B1 : BOOL;
    B2 : BOOL;
    BP : BOOL;
    C1 : BOOL;
    C2 : BOOL;
    CP : BOOL;
    Lights0 : Lights;
    A1G : BOOL;
    A1Y : BOOL;
    A1R : BOOL;
    A1_MODE : BOOL;
    _TMP_ADD6_ENO : BOOL;
    _TMP_ADD6_OUT : DINT;
    _TMP_GE10_OUT : BOOL;
    _TMP_MOVE47_ENO : BOOL;
    _TMP_MOVE47_OUT : DINT;
    _TMP_GE23_OUT : BOOL;
    _TMP_MOVE8_ENO : BOOL;
    _TMP_MOVE8_OUT : DINT;
    _TMP_EQ39_OUT : BOOL;
    _TMP_EQ41_OUT : BOOL;
    _TMP_EQ43_OUT : BOOL;
    _TMP_ADD19_ENO : BOOL;
    _TMP_ADD19_OUT : DINT;
  END_VAR

  TIMER := NOT(TIMER);
  _TMP_ADD6_OUT := ADD(EN := TIMER, IN1 := 1, IN2 := COUNTER, ENO => _TMP_ADD6_ENO);
  IF _TMP_ADD6_ENO THEN
      COUNTER := _TMP_ADD6_OUT;
  END_IF;
  _TMP_GE10_OUT := GE(COUNTER, STOPLIGHT_STOP_TIME);
  _TMP_MOVE47_OUT := MOVE(EN := _TMP_GE10_OUT, IN := 0, ENO => _TMP_MOVE47_ENO);
  IF _TMP_MOVE47_ENO THEN
      COUNTER := _TMP_MOVE47_OUT;
  END_IF;
  _TMP_GE23_OUT := GE(STATE, 3);
  _TMP_MOVE8_OUT := MOVE(EN := _TMP_GE23_OUT, IN := 0, ENO => _TMP_MOVE8_ENO);
  IF _TMP_MOVE8_ENO THEN
      STATE := _TMP_MOVE8_OUT;
  END_IF;
  _TMP_EQ39_OUT := EQ(STATE, 0);
  _TMP_EQ41_OUT := EQ(STATE, 1);
  A1 := _TMP_EQ39_OUT OR _TMP_EQ41_OUT;
  A2 := _TMP_EQ39_OUT;
  _TMP_EQ43_OUT := EQ(STATE, 2);
  AP := _TMP_EQ43_OUT;
  B1 := _TMP_EQ41_OUT OR _TMP_EQ43_OUT;
  B2 := _TMP_EQ41_OUT;
  BP := _TMP_EQ39_OUT;
  C2 := _TMP_EQ43_OUT;
  C1 := _TMP_EQ39_OUT OR _TMP_EQ43_OUT;
  CP := _TMP_EQ41_OUT;
  Lights0(INPUT := A1, STOP_TIME := YELLOW_STOP_TIME, EXT_CTER := COUNTER, EXT_STOP_TIME := STOPLIGHT_STOP_TIME, DUAL_Y := A1_MODE);
  A1G := Lights0.O_G;
  A1Y := Lights0.O_Y;
  A1R := Lights0.O_R;
  _TMP_ADD19_OUT := ADD(EN := _TMP_MOVE47_ENO, IN1 := STATE, IN2 := 1, ENO => _TMP_ADD19_ENO);
  IF _TMP_ADD19_ENO THEN
      STATE := _TMP_ADD19_OUT;
  END_IF;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : Stoplight_Enhanced;
  END_RESOURCE
END_CONFIGURATION