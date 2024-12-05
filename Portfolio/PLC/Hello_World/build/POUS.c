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





static inline INT __HELLOWORLD_MOVE__INT__INT1(BOOL EN,
  INT IN,
  HELLOWORLD *data__)
{
  INT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE27_ENO,);
  __res = MOVE__INT__INT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE27_ENO,,__TMP_ENO);
  return __res;
}

static inline INT __HELLOWORLD_MOVE__INT__INT2(BOOL EN,
  INT IN,
  HELLOWORLD *data__)
{
  INT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE1_ENO,);
  __res = MOVE__INT__INT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE1_ENO,,__TMP_ENO);
  return __res;
}

static inline INT __HELLOWORLD_MOVE__INT__INT3(BOOL EN,
  INT IN,
  HELLOWORLD *data__)
{
  INT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE2_ENO,);
  __res = MOVE__INT__INT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE2_ENO,,__TMP_ENO);
  return __res;
}

static inline INT __HELLOWORLD_MOVE__INT__INT4(BOOL EN,
  INT IN,
  HELLOWORLD *data__)
{
  INT __res;
  BOOL __TMP_ENO = __GET_VAR(data__->_TMP_MOVE3_ENO,);
  __res = MOVE__INT__INT(EN,
    &__TMP_ENO,
    IN);
  __SET_VAR(,data__->_TMP_MOVE3_ENO,,__TMP_ENO);
  return __res;
}

void HELLOWORLD_init__(HELLOWORLD *data__, BOOL retain) {
  __INIT_VAR(data__->SET,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESET,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->HELLO_WORLD,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->SELECT,0,retain)
  __INIT_VAR(data__->MODE_1,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MODE_2,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MODE_3,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MODE_4,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LED,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LED0,__BOOL_LITERAL(FALSE),retain)
  R_TRIG_init__(&data__->R_TRIG0,retain);
  F_TRIG_init__(&data__->F_TRIG0,retain);
  __INIT_VAR(data__->_TMP_MOVE27_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE27_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MOVE1_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE1_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MOVE2_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE2_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MOVE3_ENO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->_TMP_MOVE3_OUT,0,retain)
  __INIT_VAR(data__->_TMP_EQ35_OUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void HELLOWORLD_body__(HELLOWORLD *data__) {
  // Initialise TEMP variables

  if (__GET_VAR(data__->SET,)) {
    __SET_VAR(data__->,HELLO_WORLD,,__BOOL_LITERAL(TRUE));
  };
  if (__GET_VAR(data__->RESET,)) {
    __SET_VAR(data__->,HELLO_WORLD,,__BOOL_LITERAL(FALSE));
  };
  __SET_VAR(data__->,_TMP_MOVE27_OUT,,__HELLOWORLD_MOVE__INT__INT1(
    (BOOL)__GET_VAR(data__->MODE_1,),
    (INT)1,
    data__));
  if (__GET_VAR(data__->_TMP_MOVE27_ENO,)) {
    __SET_VAR(data__->,SELECT,,__GET_VAR(data__->_TMP_MOVE27_OUT,));
  };
  __SET_VAR(data__->,_TMP_MOVE1_OUT,,__HELLOWORLD_MOVE__INT__INT2(
    (BOOL)__GET_VAR(data__->MODE_2,),
    (INT)2,
    data__));
  if (__GET_VAR(data__->_TMP_MOVE1_ENO,)) {
    __SET_VAR(data__->,SELECT,,__GET_VAR(data__->_TMP_MOVE1_OUT,));
  };
  __SET_VAR(data__->,_TMP_MOVE2_OUT,,__HELLOWORLD_MOVE__INT__INT3(
    (BOOL)__GET_VAR(data__->MODE_3,),
    (INT)3,
    data__));
  if (__GET_VAR(data__->_TMP_MOVE2_ENO,)) {
    __SET_VAR(data__->,SELECT,,__GET_VAR(data__->_TMP_MOVE2_OUT,));
  };
  __SET_VAR(data__->,_TMP_MOVE3_OUT,,__HELLOWORLD_MOVE__INT__INT4(
    (BOOL)__GET_VAR(data__->MODE_4,),
    (INT)4,
    data__));
  if (__GET_VAR(data__->_TMP_MOVE3_ENO,)) {
    __SET_VAR(data__->,SELECT,,__GET_VAR(data__->_TMP_MOVE3_OUT,));
  };
  __SET_VAR(data__->,_TMP_EQ35_OUT,,EQ__BOOL__INT(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (INT)__GET_VAR(data__->SELECT,),
    (INT)3));
  __SET_VAR(data__->,LED,,__GET_VAR(data__->_TMP_EQ35_OUT,));
  __SET_VAR(data__->R_TRIG0.,CLK,,__GET_VAR(data__->_TMP_MOVE27_ENO,));
  R_TRIG_body__(&data__->R_TRIG0);
  __SET_VAR(data__->F_TRIG0.,CLK,,__GET_VAR(data__->_TMP_MOVE27_ENO,));
  F_TRIG_body__(&data__->F_TRIG0);
  __SET_VAR(data__->,LED0,,(__GET_VAR(data__->F_TRIG0.Q,) || __GET_VAR(data__->R_TRIG0.Q,)));

  goto __end;

__end:
  return;
} // HELLOWORLD_body__() 





