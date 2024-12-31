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





void BHASKARA_init__(BHASKARA *data__, BOOL retain) {
  __INIT_VAR(data__->A,1.0,retain)
  __INIT_VAR(data__->B,0.0,retain)
  __INIT_VAR(data__->C,-9.0,retain)
  __INIT_VAR(data__->XLINHA,0,retain)
  __INIT_VAR(data__->X2LINHA,0,retain)
  __INIT_VAR(data__->_TMP_SUB21_OUT,0,retain)
  __INIT_VAR(data__->_TMP_EXPT7_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL9_OUT,0,retain)
  __INIT_VAR(data__->_TMP_SUB4_OUT,0,retain)
  __INIT_VAR(data__->_TMP_SQRT6_OUT,0,retain)
  __INIT_VAR(data__->_TMP_ADD11_OUT,0,retain)
  __INIT_VAR(data__->_TMP_MUL17_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV13_OUT,0,retain)
  __INIT_VAR(data__->_TMP_SUB12_OUT,0,retain)
  __INIT_VAR(data__->_TMP_DIV16_OUT,0,retain)
}

// Code part
void BHASKARA_body__(BHASKARA *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,_TMP_SUB21_OUT,,SUB__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)0.0,
    (REAL)__GET_VAR(data__->B,)));
  __SET_VAR(data__->,_TMP_EXPT7_OUT,,EXPT__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->B,),
    (REAL)2.0));
  __SET_VAR(data__->,_TMP_MUL9_OUT,,MUL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)3,
    (REAL)4.0,
    (REAL)__GET_VAR(data__->A,),
    (REAL)__GET_VAR(data__->C,)));
  __SET_VAR(data__->,_TMP_SUB4_OUT,,SUB__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_EXPT7_OUT,),
    (REAL)__GET_VAR(data__->_TMP_MUL9_OUT,)));
  __SET_VAR(data__->,_TMP_SQRT6_OUT,,SQRT__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_SUB4_OUT,)));
  __SET_VAR(data__->,_TMP_ADD11_OUT,,ADD__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)__GET_VAR(data__->_TMP_SUB21_OUT,),
    (REAL)__GET_VAR(data__->_TMP_SQRT6_OUT,)));
  __SET_VAR(data__->,_TMP_MUL17_OUT,,MUL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (UINT)2,
    (REAL)2.0,
    (REAL)__GET_VAR(data__->A,)));
  __SET_VAR(data__->,_TMP_DIV13_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_ADD11_OUT,),
    (REAL)__GET_VAR(data__->_TMP_MUL17_OUT,)));
  __SET_VAR(data__->,XLINHA,,__GET_VAR(data__->_TMP_DIV13_OUT,));
  __SET_VAR(data__->,_TMP_SUB12_OUT,,SUB__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_SUB21_OUT,),
    (REAL)__GET_VAR(data__->_TMP_SQRT6_OUT,)));
  __SET_VAR(data__->,_TMP_DIV16_OUT,,DIV__REAL__REAL__REAL(
    (BOOL)__BOOL_LITERAL(TRUE),
    NULL,
    (REAL)__GET_VAR(data__->_TMP_SUB12_OUT,),
    (REAL)__GET_VAR(data__->_TMP_MUL17_OUT,)));
  __SET_VAR(data__->,X2LINHA,,__GET_VAR(data__->_TMP_DIV16_OUT,));

  goto __end;

__end:
  return;
} // BHASKARA_body__() 





