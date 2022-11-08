#include "spvm_native.h"

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

static const char* FILE_NAME = "IO/File.c";

int32_t SPVM__IO__File__STDERR(SPVM_ENV* env, SPVM_VALUE* stack) {

#ifdef stderr
  stack[0].ival = fileno(stderr);
#else
  return env->die(env, stack, "stderr is not defined in this system", FILE_NAME, __LINE__);
#endif
  
  return 0;
}

int32_t SPVM__IO__File__STDIN(SPVM_ENV* env, SPVM_VALUE* stack) {

#ifdef stdin
  stack[0].ival = fileno(stdin);
#else
  return env->die(env, stack, "stdin is not defined in this system", FILE_NAME, __LINE__);
#endif
  
  return 0;
}

int32_t SPVM__IO__File__STDOUT(SPVM_ENV* env, SPVM_VALUE* stack) {

#ifdef stdout
  stack[0].ival = fileno(stdout);
#else
  return env->die(env, stack, "stdout is not defined in this system", FILE_NAME, __LINE__);
#endif
  
  return 0;
}

int32_t SPVM__IO__File__readline(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t e;
  
  // Self
  void* obj_self = stack[0].oval;
  
  // File stream
  void* obj_io_file = env->get_field_object_by_name_v2(env, stack, obj_self, "IO::File", "stream", &e, FILE_NAME, __LINE__);
  if (e) { return e; }

  FILE* stream = (FILE*)env->get_pointer(env, stack, obj_io_file);

  if (stream == NULL) {
    stack[0].oval = NULL;
    return 0;
  }
  
  int32_t scope_id = env->enter_scope(env, stack);
  
  int32_t capacity = 80;
  void* obj_buffer = env->new_string(env, stack, NULL, capacity);
  int8_t* buffer = env->get_elems_byte(env, stack, obj_buffer);
  
  int32_t pos = 0;
  int32_t end_is_eof = 0;
  while (1) {
    int32_t ch = fgetc(stream);
    if (ch == EOF) {
      end_is_eof = 1;
      break;
    }
    else {
      if (pos >= capacity) {
        // Extend buffer capacity
        int32_t new_capacity = capacity * 2;
        void* new_object_buffer = env->new_string(env, stack, NULL, new_capacity);
        int8_t* new_buffer = env->get_elems_byte(env, stack, new_object_buffer);
        memcpy(new_buffer, buffer, capacity);
        
        int32_t removed = env->remove_mortal(env, stack, scope_id, obj_buffer);
        
        capacity = new_capacity;
        obj_buffer = new_object_buffer;
        buffer = new_buffer;
      }
      
      if (ch == '\n') {
        buffer[pos] = ch;
        pos++;
        break;
      }
      else {
        buffer[pos] = ch;
        pos++;
      }
    }
  }
  
  if (pos > 0 || !end_is_eof) {
    void* oline;
    if (pos == 0) {
      oline = env->new_string(env, stack, NULL, 0);
    }
    else {
      oline = env->new_string(env, stack, NULL, pos);
      int8_t* line = env->get_elems_byte(env, stack, oline);
      memcpy(line, buffer, pos);
    }
    
    stack[0].oval = oline;
  }
  else {
    stack[0].oval = NULL;
  }
  
  return 0;
}

int32_t SPVM__IO__File__read(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t e;
  
  // Self
  void* obj_self = stack[0].oval;
  
  // File stream
  void* obj_io_file = env->get_field_object_by_name_v2(env, stack, obj_self, "IO::File", "stream", &e, FILE_NAME, __LINE__);
  if (e) { return e; }

  FILE* stream = (FILE*)env->get_pointer(env, stack, obj_io_file);

  // Buffer
  void* obj_buffer = stack[1].oval;
  if (obj_buffer == NULL) {
    stack[0].ival = 0;
    return 0;
  }
  char* buffer = (char*)env->get_elems_byte(env, stack, obj_buffer);
  int32_t buffer_length = env->length(env, stack, obj_buffer);
  if (buffer_length == 0) {
    stack[0].ival = 0;
    return 0;
  }
  
  int32_t read_length = fread(buffer, 1, buffer_length, stream);
  
  stack[0].ival = read_length;
  
  return 0;
}

int32_t SPVM__IO__File__open(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  // File name
  void* obj_file_name = stack[0].oval;
  if (obj_file_name == NULL) {
    stack[0].oval = NULL;
    return 0;
  }
  const char* file_name = (const char*)env->get_elems_byte(env, stack, obj_file_name);
  
  // Mode
  void* omode = stack[1].oval;
  if (omode == NULL) {
    stack[0].oval = NULL;
    return 0;
  }
  const char* mode = (const char*)env->get_elems_byte(env, stack, omode);
  
  // Check mode
  int32_t valid_mode;
  const char* real_mode = NULL;
  if (strcmp(mode, "<") == 0) {
    valid_mode = 1;
    real_mode = "rb";
  }
  else if (strcmp(mode, ">") == 0) {
    valid_mode = 1;
    real_mode = "wb";
  }
  else if (strcmp(mode, ">>") == 0) {
    valid_mode = 1;
    real_mode = "wa";
  }
  else if (strcmp(mode, "+<") == 0) {
    valid_mode = 1;
    real_mode = "r+b";
  }
  else if (strcmp(mode, "+>") == 0) {
    valid_mode = 1;
    real_mode = "w+b";
  }
  else if (strcmp(mode, "+>>") == 0) {
    valid_mode = 1;
    real_mode = "a+b";
  }
  else {
    valid_mode = 0;
  }
  if (!valid_mode) {
    return env->die(env, stack, "Invalid open mode %s", mode, FILE_NAME, __LINE__);
  }
  
  errno = 0;
  FILE* stream = fopen(file_name, real_mode);
  
  if (stream) {
    int32_t e;

    void* obj_io_file = env->new_object_by_name(env, stack, "IO::File", &e, __FILE__, __LINE__);
    if (e) { return e; }

    void* obj_stream = env->new_pointer_by_name(env, stack, "Sys::IO::FileStream", stream, &e, __FILE__, __LINE__);
    if (e) { return e; }

    env->set_field_object_by_name_v2(env, stack, obj_io_file, "IO::File", "stream", obj_stream, &e, FILE_NAME, __LINE__);
    if (e) { return e; }
    
    stack[0].oval = obj_io_file;
  }
  else {
    const char* errstr = strerror(errno);
    
    return env->die(env, stack, "Can't open file \"%s\": %s", file_name, errstr, FILE_NAME, __LINE__);
  }
  
  return 0;
}

int32_t SPVM__IO__File__ftruncate(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t fd = stack[0].ival;
  
  int64_t length = stack[1].lval;
  
  int32_t status = ftruncate(fd, length);
  if (status != -1) {
    env->die(env, stack, "[System Error]ftruncate failed:%s.", env->strerror(env, stack, errno, 0), FILE_NAME, __LINE__);
    return SPVM_NATIVE_C_CLASS_ID_ERROR_SYSTEM;
  }
  
  stack[0].ival = status;
  
  return 0;
}

int32_t SPVM__IO__File__native_ungetc(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t c = stack[0].ival;

  void* obj_stream = stack[1].oval;
  if (!obj_stream) {
    return env->die(env, stack, "The $stream must be defined", FILE_NAME, __LINE__);
  }
  FILE* stream = env->get_pointer(env, stack, obj_stream);
  
  int32_t status = ungetc(c, stream);
  if (status == EOF) {
    env->die(env, stack, "[System Error]ungetc failed:%s.", env->strerror(env, stack, errno, 0), FILE_NAME, __LINE__);
    return SPVM_NATIVE_C_CLASS_ID_ERROR_SYSTEM;
  }
  
  stack[0].ival = status;
  
  return 0;
}

int32_t SPVM__IO__File__fsync(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t fd = stack[0].ival;
  
  int32_t status = fsync(fd);
  if (status != -1) {
    env->die(env, stack, "[System Error]fsync failed:%s.", env->strerror(env, stack, errno, 0), FILE_NAME, __LINE__);
    return SPVM_NATIVE_C_CLASS_ID_ERROR_SYSTEM;
  }
  
  stack[0].ival = status;
  
  return 0;
}

int32_t SPVM__IO__File__fstat_raw(SPVM_ENV* env, SPVM_VALUE* stack) {

  int32_t e = 0;
  
  int32_t fd = stack[0].ival;
  
  void* obj_stat = stack[1].oval;
  
  if (!obj_stat) {
    return env->die(env, stack, "The $stat must be defined", FILE_NAME, __LINE__);
  }
  
  struct stat* stat_buf = env->get_pointer(env, stack, obj_stat);
  
  int32_t status = fstat(fd, stat_buf);

  stack[0].ival = status;
  
  return 0;
}

int32_t SPVM__IO__File__fstat(SPVM_ENV* env, SPVM_VALUE* stack) {

  SPVM__IO__File__fstat_raw(env, stack);
  
  int32_t status = stack[0].ival;

  if (status == -1) {
    env->die(env, stack, "[System Error]fstat failed:%s", env->strerror(env, stack, errno, 0), FILE_NAME, __LINE__);
    return SPVM_NATIVE_C_CLASS_ID_ERROR_SYSTEM;
  }
  
  return 0;
}
