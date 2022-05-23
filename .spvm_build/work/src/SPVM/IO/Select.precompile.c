#ifndef SPVM_PRECOMPILE_H
#define SPVM_PRECOMPILE_H
#include <spvm_native.h>

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <inttypes.h>
#define SPVM_API_GET_OBJECT_NO_WEAKEN_ADDRESS(object) ((void*)((intptr_t)object & ~(intptr_t)1))
#define SPVM_API_GET_REF_COUNT(object) ((*(int32_t*)((intptr_t)object + (intptr_t)env->object_ref_count_offset)))
#define SPVM_API_INC_REF_COUNT_ONLY(object) ((*(int32_t*)((intptr_t)object + (intptr_t)env->object_ref_count_offset))++)
#define SPVM_API_INC_REF_COUNT(object)\
do {\
  if (object != NULL) {\
    SPVM_API_INC_REF_COUNT_ONLY(object);\
  }\
} while (0)\

#define SPVM_API_DEC_REF_COUNT_ONLY(object) ((*(int32_t*)((intptr_t)object + (intptr_t)env->object_ref_count_offset))--)
#define SPVM_API_DEC_REF_COUNT(object)\
do {\
  if (object != NULL) {\
    if (SPVM_API_GET_REF_COUNT(object) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(object); }\
    else { env->dec_ref_count(env, object); }\
  }\
} while (0)\

#define SPVM_API_ISWEAK(dist_address) (((intptr_t)*(void**)dist_address) & 1)

#define SPVM_API_OBJECT_ASSIGN(dist_address, src_object) \
do {\
  void* tmp_object = SPVM_API_GET_OBJECT_NO_WEAKEN_ADDRESS(src_object);\
  if (tmp_object != NULL) {\
    SPVM_API_INC_REF_COUNT_ONLY(tmp_object);\
  }\
  if (*(void**)(dist_address) != NULL) {\
    if (__builtin_expect(SPVM_API_ISWEAK(dist_address), 0)) { env->unweaken(env, dist_address); }\
    if (SPVM_API_GET_REF_COUNT(*(void**)(dist_address)) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(*(void**)(dist_address)); }\
    else { env->dec_ref_count(env, *(void**)(dist_address)); }\
  }\
  *(void**)(dist_address) = tmp_object;\
} while (0)\

#endif
static const char* CURRENT_CLASS_NAME = "IO::Select";
// Method declarations

// Method implementations

