void LOGGER_init__(LOGGER *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MSG,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->LEVEL,LOGLEVEL__INFO,retain)
  __INIT_VAR(data__->TRIG0,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LOGGER_body__(LOGGER *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  if ((__GET_VAR(data__->TRIG,) && !(__GET_VAR(data__->TRIG0,)))) {
    #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
    #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)

   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  
    #undef GetFbVar
    #undef SetFbVar
;
  };
  __SET_VAR(data__->,TRIG0,,__GET_VAR(data__->TRIG,));

  goto __end;

__end:
  return;
} // LOGGER_body__() 





void TFF_init__(TFF *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->INPUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LATCH,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OUTPUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void TFF_body__(TFF *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  __SET_VAR(data__->,LATCH,,__GET_VAR(data__->INPUT,));
  __SET_VAR(data__->,OUTPUT,,((!(__GET_VAR(data__->OUTPUT,)) && __GET_VAR(data__->LATCH,)) || (__GET_VAR(data__->OUTPUT,) && !(__GET_VAR(data__->LATCH,)))));

  goto __end;

__end:
  return;
} // TFF_body__() 





void LIGHTS_init__(LIGHTS *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->INPUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->O_G,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->O_Y,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->O_R,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->STOP_TIME,0,retain)
  __INIT_VAR(data__->EXT_CTER,0,retain)
  __INIT_VAR(data__->EXT_STOP_TIME,0,retain)
  __INIT_VAR(data__->DUAL_Y,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->DUAL_Y_CTER,__BOOL_LITERAL(FALSE),retain)
  R_TRIG_init__(&data__->R_TRIG0,retain);
  TFF_init__(&data__->TFF0,retain);
  __INIT_VAR(data__->_TMP_SUB72_OUT,0,retain)
  __INIT_VAR(data__->_TMP_GE75_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_NOT80_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_AND1_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_AND4_OUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LIGHTS_body__(LIGHTS *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  __SET_VAR(data__->,O_G,,(((!(__GET_VAR(data__->O_Y,)) && !(__GET_VAR(data__->O_R,))) && __GET_VAR(data__->INPUT,)) && __BOOL_LITERAL(TRUE)));
  __SET_VAR(data__->,O_R,,(!(__GET_VAR(data__->INPUT,)) && __BOOL_LITERAL(TRUE)));
  __SET_VAR(data__->,_TMP_SUB72_OUT,,SUB__DINT__DINT__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (DINT)__GET_VAR(data__->EXT_STOP_TIME,),
    (DINT)__GET_VAR(data__->EXT_CTER,)));
  __SET_VAR(data__->,_TMP_GE75_OUT,,GE__BOOL__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (DINT)__GET_VAR(data__->_TMP_SUB72_OUT,),
    (DINT)__GET_VAR(data__->STOP_TIME,)));
  __SET_VAR(data__->,_TMP_NOT80_OUT,,!(__GET_VAR(data__->_TMP_GE75_OUT,)));
  __SET_VAR(data__->,_TMP_AND1_OUT,,AND__BOOL__BOOL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (BOOL)(__GET_VAR(data__->INPUT,) && __BOOL_LITERAL(TRUE)),
    (BOOL)__GET_VAR(data__->_TMP_NOT80_OUT,)));
  __SET_VAR(data__->,_TMP_AND4_OUT,,AND__BOOL__BOOL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (BOOL)__GET_VAR(data__->_TMP_AND1_OUT,),
    (BOOL)!(__GET_VAR(data__->DUAL_Y_CTER,))));
  __SET_VAR(data__->,O_Y,,__GET_VAR(data__->_TMP_AND4_OUT,));
  __SET_VAR(data__->R_TRIG0.,CLK,,(__GET_VAR(data__->DUAL_Y,) && __GET_VAR(data__->_TMP_AND1_OUT,)));
  R_TRIG_body__(&data__->R_TRIG0);
  __SET_VAR(data__->TFF0.,INPUT,,__GET_VAR(data__->R_TRIG0.Q,));
  TFF_body__(&data__->TFF0);
  __SET_VAR(data__->,DUAL_Y_CTER,,__GET_VAR(data__->TFF0.OUTPUT,));

  goto __end;

__end:
  return;
} // LIGHTS_body__() 





static inline DINT __STOPLIGHT_ENHANCED_ADD__DINT__DINT1(BOOL EN,
  UINT __PARAM_COUNT,
  DINT IN1,
  DINT IN2,
  STOPLIGHT_ENHANCED *data__)
{
  DINT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_ADD6_ENO,);
  __res = ADD__DINT__DINT(EN,
    &__TMP_ENO,
    __PARAM_COUNT,
    IN1,
    IN2);
  __SET_VAR(,data__->_TMP_ADD6_ENO,,__TMP_ENO);
  return __res;
}

static inline DINT __STOPLIGHT_ENHANCED_MOVE__DINT__DINT2(BOOL EN,
  DINT IN,
  STOPLIGHT_ENHANCED *data__)
{
  DINT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE47_ENO,);
  __res = MOVE__DINT__DINT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE47_ENO,,__TMP_ENO);
  return __res;
}

static inline DINT __STOPLIGHT_ENHANCED_MOVE__DINT__DINT3(BOOL EN,
  DINT IN,
  STOPLIGHT_ENHANCED *data__)
{
  DINT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE8_ENO,);
  __res = MOVE__DINT__DINT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE8_ENO,,__TMP_ENO);
  return __res;
}

static inline DINT __STOPLIGHT_ENHANCED_ADD__DINT__DINT4(BOOL EN,
  UINT __PARAM_COUNT,
  DINT IN1,
  DINT IN2,
  STOPLIGHT_ENHANCED *data__)
{
  DINT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_ADD19_ENO,);
  __res = ADD__DINT__DINT(EN,
    &__TMP_ENO,
    __PARAM_COUNT,
    IN1,
    IN2);
  __SET_VAR(,data__->_TMP_ADD19_ENO,,__TMP_ENO);
  return __res;
}

void STOPLIGHT_ENHANCED_init__(STOPLIGHT_ENHANCED *data__, BOOL retain) {
  __INIT_VAR(data__->TIMER,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->COUNTER,0,retain)
  __INIT_VAR(data__->STOPLIGHT_STOP_TIME,200,retain)
  __INIT_VAR(data__->YELLOW_STOP_TIME,40,retain)
  __INIT_VAR(data__->STATE,0,retain)
  __INIT_VAR(data__->A1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->A2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->AP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->B1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->B2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->C1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->C2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CP,__BOOL_LITERAL(FALSE),retain)
  LIGHTS_init__(&data__->LIGHTS0,retain);
  __INIT_VAR(data__->A1G,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->A1Y,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->A1R,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->A1_MODE,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_ADD6_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_ADD6_OUT,0,retain)
  __INIT_VAR(data__->_TMP_GE10_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE47_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE47_OUT,0,retain)
  __INIT_VAR(data__->_TMP_GE23_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE8_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE8_OUT,0,retain)
  __INIT_VAR(data__->_TMP_EQ39_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ41_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ43_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_ADD19_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_ADD19_OUT,0,retain)
}

// Code part
void STOPLIGHT_ENHANCED_body__(STOPLIGHT_ENHANCED *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,TIMER,,!(__GET_VAR(data__->TIMER,)));
  __SET_VAR(data__->,_TMP_ADD6_OUT,,__STOPLIGHT_ENHANCED_ADD__DINT__DINT1(
    (BOOL)__GET_VAR(data__->TIMER,),
    (UINT)2,
    (DINT)1,
    (DINT)__GET_VAR(data__->COUNTER,),
    data__));
  if (__GET_VAR(data__->_TMP_ADD6_ENO,)) {
    __SET_VAR(data__->,COUNTER,,__GET_VAR(data__->_TMP_ADD6_OUT,));
  };
  __SET_VAR(data__->,_TMP_GE10_OUT,,GE__BOOL__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (DINT)__GET_VAR(data__->COUNTER,),
    (DINT)__GET_VAR(data__->STOPLIGHT_STOP_TIME,)));
  __SET_VAR(data__->,_TMP_MOVE47_OUT,,__STOPLIGHT_ENHANCED_MOVE__DINT__DINT2(
    (BOOL)__GET_VAR(data__->_TMP_GE10_OUT,),
    (DINT)0,
    data__));
  if (__GET_VAR(data__->_TMP_MOVE47_ENO,)) {
    __SET_VAR(data__->,COUNTER,,__GET_VAR(data__->_TMP_MOVE47_OUT,));
  };
  __SET_VAR(data__->,_TMP_GE23_OUT,,GE__BOOL__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (DINT)__GET_VAR(data__->STATE,),
    (DINT)3));
  __SET_VAR(data__->,_TMP_MOVE8_OUT,,__STOPLIGHT_ENHANCED_MOVE__DINT__DINT3(
    (BOOL)__GET_VAR(data__->_TMP_GE23_OUT,),
    (DINT)0,
    data__));
  if (__GET_VAR(data__->_TMP_MOVE8_ENO,)) {
    __SET_VAR(data__->,STATE,,__GET_VAR(data__->_TMP_MOVE8_OUT,));
  };
  __SET_VAR(data__->,_TMP_EQ39_OUT,,EQ__BOOL__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (DINT)__GET_VAR(data__->STATE,),
    (DINT)0));
  __SET_VAR(data__->,_TMP_EQ41_OUT,,EQ__BOOL__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (DINT)__GET_VAR(data__->STATE,),
    (DINT)1));
  __SET_VAR(data__->,A1,,(__GET_VAR(data__->_TMP_EQ39_OUT,) || __GET_VAR(data__->_TMP_EQ41_OUT,)));
  __SET_VAR(data__->,A2,,__GET_VAR(data__->_TMP_EQ39_OUT,));
  __SET_VAR(data__->,_TMP_EQ43_OUT,,EQ__BOOL__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (DINT)__GET_VAR(data__->STATE,),
    (DINT)2));
  __SET_VAR(data__->,AP,,__GET_VAR(data__->_TMP_EQ43_OUT,));
  __SET_VAR(data__->,B1,,(__GET_VAR(data__->_TMP_EQ41_OUT,) || __GET_VAR(data__->_TMP_EQ43_OUT,)));
  __SET_VAR(data__->,B2,,__GET_VAR(data__->_TMP_EQ41_OUT,));
  __SET_VAR(data__->,BP,,__GET_VAR(data__->_TMP_EQ39_OUT,));
  __SET_VAR(data__->,C2,,__GET_VAR(data__->_TMP_EQ43_OUT,));
  __SET_VAR(data__->,C1,,(__GET_VAR(data__->_TMP_EQ39_OUT,) || __GET_VAR(data__->_TMP_EQ43_OUT,)));
  __SET_VAR(data__->,CP,,__GET_VAR(data__->_TMP_EQ41_OUT,));
  __SET_VAR(data__->LIGHTS0.,INPUT,,__GET_VAR(data__->A1,));
  __SET_VAR(data__->LIGHTS0.,STOP_TIME,,__GET_VAR(data__->YELLOW_STOP_TIME,));
  __SET_VAR(data__->LIGHTS0.,EXT_CTER,,__GET_VAR(data__->COUNTER,));
  __SET_VAR(data__->LIGHTS0.,EXT_STOP_TIME,,__GET_VAR(data__->STOPLIGHT_STOP_TIME,));
  __SET_VAR(data__->LIGHTS0.,DUAL_Y,,__GET_VAR(data__->A1_MODE,));
  LIGHTS_body__(&data__->LIGHTS0);
  __SET_VAR(data__->,A1G,,__GET_VAR(data__->LIGHTS0.O_G,));
  __SET_VAR(data__->,A1Y,,__GET_VAR(data__->LIGHTS0.O_Y,));
  __SET_VAR(data__->,A1R,,__GET_VAR(data__->LIGHTS0.O_R,));
  __SET_VAR(data__->,_TMP_ADD19_OUT,,__STOPLIGHT_ENHANCED_ADD__DINT__DINT4(
    (BOOL)__GET_VAR(data__->_TMP_MOVE47_ENO,),
    (UINT)2,
    (DINT)__GET_VAR(data__->STATE,),
    (DINT)1,
    data__));
  if (__GET_VAR(data__->_TMP_ADD19_ENO,)) {
    __SET_VAR(data__->,STATE,,__GET_VAR(data__->_TMP_ADD19_OUT,));
  };

  goto __end;

__end:
  return;
} // STOPLIGHT_ENHANCED_body__() 





