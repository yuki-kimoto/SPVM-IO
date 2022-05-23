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
static const char* CURRENT_CLASS_NAME = "IO::File";
// Method declarations
int32_t SPVMPRECOMPILE__IO__File__slurp(SPVM_ENV* env, SPVM_VALUE* stack);

// Method implementations
int32_t SPVMPRECOMPILE__IO__File__slurp(SPVM_ENV* env, SPVM_VALUE* stack) {
  const char* CURRENT_METHOD_NAME = "slurp";
  int32_t object_header_byte_size = (intptr_t)env->object_header_byte_size;
  void* object_vars[6] = {0};
  int32_t int_vars[6];
  int32_t exception_flag = 0;
  int32_t mortal_stack[9];
  int32_t mortal_stack_top = 0;
  char convert_string_buffer[21];
L0: // GET_ARG_OBJECT
  {
    int32_t arg_mem_id = 0;
    int32_t stack_index = 0;
    object_vars[arg_mem_id] = *(void**)&stack[stack_index];
    void* object = *(void**)&object_vars[arg_mem_id];
    if (object != NULL) {
      SPVM_API_INC_REF_COUNT_ONLY(object);
    }
  }
L1: // GET_ARG_OBJECT
  {
    int32_t arg_mem_id = 1;
    int32_t stack_index = 1;
    object_vars[arg_mem_id] = *(void**)&stack[stack_index];
    void* object = *(void**)&object_vars[arg_mem_id];
    if (object != NULL) {
      SPVM_API_INC_REF_COUNT_ONLY(object);
    }
  }
L2: // INIT_INT
  int_vars[0] = 0;
L3: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 0;
  mortal_stack_top++;
L4: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 1;
  mortal_stack_top++;
L5: // MOVE_CONSTANT_INT
  int_vars[1] = 4096;
L6: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 2;
  mortal_stack_top++;
L7: // NEW_BYTE_ARRAY
  {
    int32_t length = *(int32_t*)&int_vars[1];
    if (length >= 0) {
      void* object = env->new_byte_array_raw(env, length);
      if (object == NULL) {
        void* exception = env->new_string_nolen_raw(env, "Can't allocate memory for byte array");
        env->set_exception(env, exception);
        exception_flag = 1;
      }
      else {
        SPVM_API_OBJECT_ASSIGN((void**)&object_vars[2], object);
      }
    }
    else {
      void* exception = env->new_string_nolen_raw(env, "Array length must be more than or equal to 0");
      env->set_exception(env, exception);
      exception_flag = 1;
    }
  }
L8: // IF_EXCEPTION_RETURN
  if (exception_flag) {
    int32_t line = 35;
    int32_t method_id = env->api->runtime->get_method_id_by_name(env->runtime, CURRENT_CLASS_NAME, CURRENT_METHOD_NAME);
    env->set_exception(env, env->new_stack_trace_raw(env, env->get_exception(env), method_id, line));
    goto L51;
  }
L9: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 3;
  mortal_stack_top++;
L10: // NEW_STRING
  {
    void* string = env->new_string_raw(env, "", 0);
    if (string == NULL) {
      void* exception = env->new_string_nolen_raw(env, "Can't allocate memory for string");
      env->set_exception(env, exception);
      exception_flag = 1;
    }
    else {
      env->make_read_only(env, string);
      SPVM_API_OBJECT_ASSIGN(&object_vars[3], string);
    }
  }
L11: // GOTO
  goto L43;
L12: // PUSH_ARG_OBJECT
  *(void**)&stack[0] = object_vars[0];
L13: // PUSH_ARG_OBJECT
  *(void**)&stack[1] = object_vars[2];
L14: // CALL_INSTANCE_METHOD_BY_ID
  // IO::File->read
  {
    int32_t access_method_id = env->get_method_id_cache(env, "IO::File|read|int(self,byte[])", 30);
    int32_t call_method_id = access_method_id;
    if (call_method_id < 0) {
      void* exception = env->new_string_nolen_raw(env, "Can't find the \"read\" method with the signature \"int(self,byte[])\" that is declared in \"IO::File\"");
      env->set_exception(env, exception);      exception_flag = 1;
    }
    if (!exception_flag) { exception_flag = env->call_spvm_method(env, call_method_id, stack); }
    if (!exception_flag) {
      int_vars[3] = *(int32_t*)&stack[0];
    }
  }
L15: // IF_EXCEPTION_RETURN
  if (exception_flag) {
    int32_t line = 38;
    int32_t method_id = env->api->runtime->get_method_id_by_name(env->runtime, CURRENT_CLASS_NAME, CURRENT_METHOD_NAME);
    env->set_exception(env, env->new_stack_trace_raw(env, env->get_exception(env), method_id, line));
    goto L51;
  }
L16: // LT_INT
  int_vars[0] = (int_vars[3] < int_vars[1]);
L17: // BOOL_INT
  int_vars[0] = int_vars[0];
L18: // IF_EQ_ZERO
  if (int_vars[0] == 0) { goto L34; }
L19: // MOVE_CONSTANT_INT
  int_vars[4] = 0;
L20: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 4;
  mortal_stack_top++;
L21: // PUSH_ARG_OBJECT
  *(void**)&stack[0] = object_vars[2];
L22: // PUSH_ARG_INT
  *(int32_t*)&stack[1] = int_vars[4];
L23: // PUSH_ARG_INT
  *(int32_t*)&stack[2] = int_vars[3];
L24: // CALL_CLASS_METHOD_BY_ID
  // Fn->copy_array_range_byte
  {
    int32_t access_method_id = env->get_method_id_cache(env, "Fn|copy_array_range_byte|byte[](byte[],int,int)", 47);
    int32_t call_method_id = access_method_id;
    if (call_method_id < 0) {
      void* exception = env->new_string_nolen_raw(env, "Can't find the \"copy_array_range_byte\" method with the signature \"byte[](byte[],int,int)\" that is declared in \"Fn\"");
      env->set_exception(env, exception);      exception_flag = 1;
    }
    if (!exception_flag) { exception_flag = env->call_spvm_method(env, call_method_id, stack); }
    if (!exception_flag) {
      SPVM_API_OBJECT_ASSIGN(&object_vars[4], stack[0].oval);
    }
  }
L25: // IF_EXCEPTION_RETURN
  if (exception_flag) {
    int32_t line = 41;
    int32_t method_id = env->api->runtime->get_method_id_by_name(env->runtime, CURRENT_CLASS_NAME, CURRENT_METHOD_NAME);
    env->set_exception(env, env->new_stack_trace_raw(env, env->get_exception(env), method_id, line));
    goto L51;
  }
L26: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 5;
  mortal_stack_top++;
L27: // TYPE_CONVERSION_BYTE_ARRAY_TO_STRING
  {
    void* src_byte_array = object_vars[4];
    int32_t src_byte_array_length = env->length(env, src_byte_array);    int8_t* src_byte_array_data = env->get_elems_byte(env, src_byte_array);    void* string = env->new_string_raw(env, (const char*)src_byte_array_data, src_byte_array_length);    SPVM_API_OBJECT_ASSIGN(&object_vars[5], string);
  }
L28: // CONCAT
  {
    void* string1 = object_vars[3];
    void* string2 = object_vars[5];
    if (string1 == NULL) {
      void* exception = env->new_string_nolen_raw(env, "\".\" operater left value must be defined");
      env->set_exception(env, exception);
      exception_flag = 1;
    }
    else if (string2 == NULL) {
      void* exception = env->new_string_nolen_raw(env, "\".\" operater right value must be defined");
      env->set_exception(env, exception);
      exception_flag = 1;
    }
    else {
      void* string3 = env->concat_raw(env, string1, string2);
      SPVM_API_OBJECT_ASSIGN(&object_vars[3], string3);
    }
  }
L29: // IF_EXCEPTION_RETURN
  if (exception_flag) {
    int32_t line = 41;
    int32_t method_id = env->api->runtime->get_method_id_by_name(env->runtime, CURRENT_CLASS_NAME, CURRENT_METHOD_NAME);
    env->set_exception(env, env->new_stack_trace_raw(env, env->get_exception(env), method_id, line));
    goto L51;
  }
L30: // INIT_UNDEF
  SPVM_API_OBJECT_ASSIGN(&object_vars[5], NULL);
L31: // INIT_UNDEF
  SPVM_API_OBJECT_ASSIGN(&object_vars[4], NULL);
L32: // GOTO
  goto L46;
L33: // GOTO
  goto L40;
L34: // LEAVE_SCOPE
  {
    int32_t original_mortal_stack_top = 4;
    {
      int32_t mortal_stack_index;
      for (mortal_stack_index = original_mortal_stack_top; mortal_stack_index < mortal_stack_top; mortal_stack_index++) {
        int32_t var_index = mortal_stack[mortal_stack_index];
        void** object_address = (void**)&object_vars[var_index];
        if (*object_address != NULL) {
          if (SPVM_API_GET_REF_COUNT(*object_address) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(*object_address); }
          else { env->dec_ref_count(env, *object_address); }
          *object_address = NULL;
        }
      }
    }
    mortal_stack_top = original_mortal_stack_top;
  }
L35: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 4;
  mortal_stack_top++;
L36: // TYPE_CONVERSION_BYTE_ARRAY_TO_STRING
  {
    void* src_byte_array = object_vars[2];
    int32_t src_byte_array_length = env->length(env, src_byte_array);    int8_t* src_byte_array_data = env->get_elems_byte(env, src_byte_array);    void* string = env->new_string_raw(env, (const char*)src_byte_array_data, src_byte_array_length);    SPVM_API_OBJECT_ASSIGN(&object_vars[4], string);
  }
L37: // CONCAT
  {
    void* string1 = object_vars[3];
    void* string2 = object_vars[4];
    if (string1 == NULL) {
      void* exception = env->new_string_nolen_raw(env, "\".\" operater left value must be defined");
      env->set_exception(env, exception);
      exception_flag = 1;
    }
    else if (string2 == NULL) {
      void* exception = env->new_string_nolen_raw(env, "\".\" operater right value must be defined");
      env->set_exception(env, exception);
      exception_flag = 1;
    }
    else {
      void* string3 = env->concat_raw(env, string1, string2);
      SPVM_API_OBJECT_ASSIGN(&object_vars[3], string3);
    }
  }
L38: // IF_EXCEPTION_RETURN
  if (exception_flag) {
    int32_t line = 45;
    int32_t method_id = env->api->runtime->get_method_id_by_name(env->runtime, CURRENT_CLASS_NAME, CURRENT_METHOD_NAME);
    env->set_exception(env, env->new_stack_trace_raw(env, env->get_exception(env), method_id, line));
    goto L51;
  }
L39: // INIT_UNDEF
  SPVM_API_OBJECT_ASSIGN(&object_vars[4], NULL);
L40: // LEAVE_SCOPE
  {
    int32_t original_mortal_stack_top = 4;
    {
      int32_t mortal_stack_index;
      for (mortal_stack_index = original_mortal_stack_top; mortal_stack_index < mortal_stack_top; mortal_stack_index++) {
        int32_t var_index = mortal_stack[mortal_stack_index];
        void** object_address = (void**)&object_vars[var_index];
        if (*object_address != NULL) {
          if (SPVM_API_GET_REF_COUNT(*object_address) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(*object_address); }
          else { env->dec_ref_count(env, *object_address); }
          *object_address = NULL;
        }
      }
    }
    mortal_stack_top = original_mortal_stack_top;
  }
L41: // LEAVE_SCOPE
  {
    int32_t original_mortal_stack_top = 4;
    {
      int32_t mortal_stack_index;
      for (mortal_stack_index = original_mortal_stack_top; mortal_stack_index < mortal_stack_top; mortal_stack_index++) {
        int32_t var_index = mortal_stack[mortal_stack_index];
        void** object_address = (void**)&object_vars[var_index];
        if (*object_address != NULL) {
          if (SPVM_API_GET_REF_COUNT(*object_address) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(*object_address); }
          else { env->dec_ref_count(env, *object_address); }
          *object_address = NULL;
        }
      }
    }
    mortal_stack_top = original_mortal_stack_top;
  }
L42: // LEAVE_SCOPE
  {
    int32_t original_mortal_stack_top = 4;
    {
      int32_t mortal_stack_index;
      for (mortal_stack_index = original_mortal_stack_top; mortal_stack_index < mortal_stack_top; mortal_stack_index++) {
        int32_t var_index = mortal_stack[mortal_stack_index];
        void** object_address = (void**)&object_vars[var_index];
        if (*object_address != NULL) {
          if (SPVM_API_GET_REF_COUNT(*object_address) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(*object_address); }
          else { env->dec_ref_count(env, *object_address); }
          *object_address = NULL;
        }
      }
    }
    mortal_stack_top = original_mortal_stack_top;
  }
L43: // MOVE_CONSTANT_INT
  int_vars[3] = 1;
L44: // BOOL_INT
  int_vars[0] = int_vars[3];
L45: // IF_NE_ZERO
  if (int_vars[0]) { goto L12; }
L46: // LEAVE_SCOPE
  {
    int32_t original_mortal_stack_top = 4;
    {
      int32_t mortal_stack_index;
      for (mortal_stack_index = original_mortal_stack_top; mortal_stack_index < mortal_stack_top; mortal_stack_index++) {
        int32_t var_index = mortal_stack[mortal_stack_index];
        void** object_address = (void**)&object_vars[var_index];
        if (*object_address != NULL) {
          if (SPVM_API_GET_REF_COUNT(*object_address) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(*object_address); }
          else { env->dec_ref_count(env, *object_address); }
          *object_address = NULL;
        }
      }
    }
    mortal_stack_top = original_mortal_stack_top;
  }
L47: // RETURN_OBJECT
  *(void**)&stack[0] = object_vars[3];
  if (*(void**)&stack[0] != NULL) {
    SPVM_API_INC_REF_COUNT_ONLY(*(void**)&stack[0]);
  }
  goto L51;
L48: // PUSH_MORTAL
  mortal_stack[mortal_stack_top] = 4;
  mortal_stack_top++;
L49: // INIT_UNDEF
  SPVM_API_OBJECT_ASSIGN(&object_vars[4], NULL);
L50: // RETURN_OBJECT
  *(void**)&stack[0] = object_vars[4];
  if (*(void**)&stack[0] != NULL) {
    SPVM_API_INC_REF_COUNT_ONLY(*(void**)&stack[0]);
  }
  goto L51;
L51: // LEAVE_SCOPE
  {
    int32_t original_mortal_stack_top = 0;
    {
      int32_t mortal_stack_index;
      for (mortal_stack_index = original_mortal_stack_top; mortal_stack_index < mortal_stack_top; mortal_stack_index++) {
        int32_t var_index = mortal_stack[mortal_stack_index];
        void** object_address = (void**)&object_vars[var_index];
        if (*object_address != NULL) {
          if (SPVM_API_GET_REF_COUNT(*object_address) > 1) { SPVM_API_DEC_REF_COUNT_ONLY(*object_address); }
          else { env->dec_ref_count(env, *object_address); }
          *object_address = NULL;
        }
      }
    }
    mortal_stack_top = original_mortal_stack_top;
  }
L52: // END_METHOD
  if (!exception_flag) {
    if (stack[0].oval != NULL) { SPVM_API_DEC_REF_COUNT_ONLY(stack[0].oval); }
  }
  return exception_flag;
}


