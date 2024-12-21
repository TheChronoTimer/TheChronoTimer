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
// FUNCTION_BLOCK TFF
// Data part
typedef struct {
  // FB Interface - IN, OUT, IN_OUT variables
  __DECLARE_VAR(BOOL,EN)
  __DECLARE_VAR(BOOL,ENO)
  __DECLARE_VAR(BOOL,INPUT)
  __DECLARE_VAR(BOOL,OUTPUT)

  // FB private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,LATCH)

} TFF;

void TFF_init__(TFF *data__, BOOL retain);
// Code part
void TFF_body__(TFF *data__);
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
// PROGRAM BLOCKS
// Data part
typedef struct {
  // PROGRAM Interface - IN, OUT, IN_OUT variables

  // PROGRAM private variables - TEMP, private and located variables
  __DECLARE_VAR(BOOL,INPUT)
  __DECLARE_VAR(BOOL,OUTPUT0)
  __DECLARE_VAR(BOOL,OUTPUT1)
  TFF TFF0;
  ONS ONS0;

} BLOCKS;

void BLOCKS_init__(BLOCKS *data__, BOOL retain);
// Code part
void BLOCKS_body__(BLOCKS *data__);
#endif //__POUS_H
