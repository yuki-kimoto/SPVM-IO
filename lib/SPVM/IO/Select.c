#ifndef _XOPEN_SOURCE
#  define _XOPEN_SOURCE
#endif

#include "spvm_native.h"

#ifdef _WIN32
  #include <winsock.h>
#else
  #include <sys/types.h>
  #include <sys/time.h>
#endif

#include <math.h>

// Module file name
static const char* FILE_NAME = "Webkit/Select.c";

