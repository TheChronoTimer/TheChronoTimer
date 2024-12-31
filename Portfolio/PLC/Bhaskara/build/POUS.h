#include "beremiz.h"
#ifndef __POUS_H
#define __POUS_H

#include "accessor.h"
#include "iec_std_lib.h"

__DECLARE_ENUMERATED_TYPE(LOGLEVEL,
  LOGLEVEL__CRITICAL,
  LOGLEVEL__WARNING,
  LOGLEVEL__INFO,
  LOGLEVEL__DEBUG
)
// FUNCTION_BLOCK LOGGER
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,TRIG)
  __DECLARE_VAR(STRING,MSG)
  __DECLARE_VAR(LOGLEVEL,LEVEL)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,TRIG0)

} LOGGER;

void LOGGER_init__(LOGGER *data__, BOOL retain);
// Code part
void LOGGER_body__(LOGGER *data__);
// PROGRAM BHASKARA
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_VAR(REAL,A)
  __DECLARE_VAR(REAL,B)
  __DECLARE_VAR(REAL,C)
  __DECLARE_VAR(REAL,XLINHA)
  __DECLARE_VAR(REAL,X2LINHA)
  __DECLARE_VAR(REAL,_TMP_SUB21_OUT)
  __DECLARE_VAR(REAL,_TMP_EXPT7_OUT)
  __DECLARE_VAR(REAL,_TMP_MUL9_OUT)
  __DECLARE_VAR(REAL,_TMP_SUB4_OUT)
  __DECLARE_VAR(REAL,_TMP_SQRT6_OUT)
  __DECLARE_VAR(REAL,_TMP_ADD11_OUT)
  __DECLARE_VAR(REAL,_TMP_MUL17_OUT)
  __DECLARE_VAR(REAL,_TMP_DIV13_OUT)
  __DECLARE_VAR(REAL,_TMP_SUB12_OUT)
  __DECLARE_VAR(REAL,_TMP_DIV16_OUT)

} BHASKARA;

void BHASKARA_init__(BHASKARA *data__, BOOL retain);
// Code part
void BHASKARA_body__(BHASKARA *data__);
#endif //__POUS_H
