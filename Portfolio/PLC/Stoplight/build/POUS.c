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





static inline DINT __STOPLIGHT_ADD__DINT__DINT1(BOOL EN,
  UINT __PARAM_COUNT,
  DINT IN1,
  DINT IN2,
  STOPLIGHT *data__)
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

static inline DINT __STOPLIGHT_MOVE__DINT__DINT2(BOOL EN,
  DINT IN,
  STOPLIGHT *data__)
{
  DINT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE47_ENO,);
  __res = MOVE__DINT__DINT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE47_ENO,,__TMP_ENO);
  return __res;
}

static inline DINT __STOPLIGHT_ADD__DINT__DINT3(BOOL EN,
  UINT __PARAM_COUNT,
  DINT IN1,
  DINT IN2,
  STOPLIGHT *data__)
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

static inline DINT __STOPLIGHT_MOVE__DINT__DINT4(BOOL EN,
  DINT IN,
  STOPLIGHT *data__)
{
  DINT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE8_ENO,);
  __res = MOVE__DINT__DINT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE8_ENO,,__TMP_ENO);
  return __res;
}

void STOPLIGHT_init__(STOPLIGHT *data__, BOOL retain) {
  __INIT_VAR(data__->COUNTER,0,retain)
  __INIT_VAR(data__->STATE,0,retain)
  __INIT_VAR(data__->STOPLIGHT_TIME,30,retain)
  __INIT_VAR(data__->TIMER,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->A1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->A2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->AP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->B1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->B2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->BP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->C1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->C2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_ADD6_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_ADD6_OUT,0,retain)
  __INIT_VAR(data__->_TMP_GE10_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE47_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE47_OUT,0,retain)
  __INIT_VAR(data__->_TMP_ADD19_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_ADD19_OUT,0,retain)
  __INIT_VAR(data__->_TMP_GE23_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE8_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE8_OUT,0,retain)
  __INIT_VAR(data__->_TMP_EQ39_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ41_OUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_EQ43_OUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void STOPLIGHT_body__(STOPLIGHT *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,TIMER,,!(__GET_VAR(data__->TIMER,)));
  __SET_VAR(data__->,_TMP_ADD6_OUT,,__STOPLIGHT_ADD__DINT__DINT1(
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
    (DINT)__GET_VAR(data__->STOPLIGHT_TIME,)));
  __SET_VAR(data__->,_TMP_MOVE47_OUT,,__STOPLIGHT_MOVE__DINT__DINT2(
    (BOOL)__GET_VAR(data__->_TMP_GE10_OUT,),
    (DINT)0,
    data__));
  if (__GET_VAR(data__->_TMP_MOVE47_ENO,)) {
    __SET_VAR(data__->,COUNTER,,__GET_VAR(data__->_TMP_MOVE47_OUT,));
  };
  __SET_VAR(data__->,_TMP_ADD19_OUT,,__STOPLIGHT_ADD__DINT__DINT3(
    (BOOL)__GET_VAR(data__->_TMP_MOVE47_ENO,),
    (UINT)2,
    (DINT)__GET_VAR(data__->STATE,),
    (DINT)1,
    data__));
  if (__GET_VAR(data__->_TMP_ADD19_ENO,)) {
    __SET_VAR(data__->,STATE,,__GET_VAR(data__->_TMP_ADD19_OUT,));
  };
  __SET_VAR(data__->,_TMP_GE23_OUT,,GE__BOOL__DINT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (DINT)__GET_VAR(data__->STATE,),
    (DINT)3));
  __SET_VAR(data__->,_TMP_MOVE8_OUT,,__STOPLIGHT_MOVE__DINT__DINT4(
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

  goto __end;

__end:
  return;
} // STOPLIGHT_body__() 





