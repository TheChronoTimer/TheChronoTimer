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





void ONS_init__(ONS *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->INPUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OUTPUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LATCH,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void ONS_body__(ONS *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  __SET_VAR(data__->,OUTPUT,,(!(__GET_VAR(data__->LATCH,)) && __GET_VAR(data__->INPUT,)));
  if (__GET_VAR(data__->INPUT,)) {
    __SET_VAR(data__->,LATCH,,__BOOL_LITERAL(TRUE));
  };
  if (!(__GET_VAR(data__->INPUT,))) {
    __SET_VAR(data__->,LATCH,,__BOOL_LITERAL(FALSE));
  };

  goto __end;

__end:
  return;
} // ONS_body__() 





void ONS_ONESHOT_init__(ONS_ONESHOT *data__, BOOL retain) {
  ONS_init__(&data__->ONS0,retain);
  __INIT_VAR(data__->INPUT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->OUTPUT,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void ONS_ONESHOT_body__(ONS_ONESHOT *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->ONS0.,INPUT,,__GET_VAR(data__->INPUT,));
  ONS_body__(&data__->ONS0);
  __SET_VAR(data__->,OUTPUT,,__GET_VAR(data__->ONS0.OUTPUT,));

  goto __end;

__end:
  return;
} // ONS_ONESHOT_body__() 





