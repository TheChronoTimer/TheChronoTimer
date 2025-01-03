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
// FUNCTION_BLOCK ONS
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,INPUT)
  __DECLARE_VAR(BOOL,OUTPUT)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,LATCH)

} ONS;

void ONS_init__(ONS *data__, BOOL retain);
// Code part
void ONS_body__(ONS *data__);
// PROGRAM ONS_ONESHOT
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  ONS ONS0;
  __DECLARE_VAR(BOOL,INPUT)
  __DECLARE_VAR(BOOL,OUTPUT)

} ONS_ONESHOT;

void ONS_ONESHOT_init__(ONS_ONESHOT *data__, BOOL retain);
// Code part
void ONS_ONESHOT_body__(ONS_ONESHOT *data__);
#endif //__POUS_H
