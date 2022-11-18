// Windows 8.1+
#define _WIN32_WINNT 0x0603

#include "spvm_native.h"

#include <errno.h>
#include <assert.h>

#ifdef _WIN32
  #include <ws2tcpip.h>
  #include <winsock2.h>
  #include <io.h>
  #include <winerror.h>
#else
  #include <unistd.h>
  #include <sys/types.h>
  #include <sys/socket.h>
  #include <netinet/in.h>
  #include <netinet/ip.h>
  #include <netdb.h>
  #include <arpa/inet.h>
#endif

static int32_t FIELD_INDEX_ADDRINFO_MEMORY_ALLOCATED = 0;
static int32_t ADDRINFO_MEMORY_ALLOCATED_BY_NEW = 1;
static int32_t ADDRINFO_MEMORY_ALLOCATED_BY_GETADDRINFO = 2;

static int32_t socket_errno (void) {
#ifdef _WIN32
  return WSAGetLastError();
#else
  return errno;
#endif
}

#ifdef _WIN32
static void* socket_strerror_string_win (SPVM_ENV* env, SPVM_VALUE* stack, int32_t error_number, int32_t length) {
  char* error_message = NULL;
  FormatMessageA(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS, 
                 NULL, error_number,
                 MAKELANGID(LANG_ENGLISH, SUBLANG_ENGLISH_US),
                 (LPSTR)&error_message, length, NULL);
  
  void* obj_error_message = env->new_string(env, stack, error_message, strlen(error_message));
  
  LocalFree(error_message);
  
  return obj_error_message;
}
#endif

static void* socket_strerror_string (SPVM_ENV* env, SPVM_VALUE* stack, int32_t error_number, int32_t length) {
  void*
#ifdef _WIN32
  obj_strerror_value = socket_strerror_string_win(env, stack, error_number, length);
#else
  obj_strerror_value = env->strerror_string(env, stack, error_number, length);
#endif
  return obj_strerror_value;
}

int32_t SPVM__Sys__Socket__socket_errno(SPVM_ENV* env, SPVM_VALUE* stack) {
  int32_t ret_socket_errno = socket_errno();
  
  stack[0].ival = ret_socket_errno;
  
  return 0;
}

int32_t SPVM__Sys__Socket__socket_strerror(SPVM_ENV* env, SPVM_VALUE* stack) {
  int32_t error_number = stack[0].ival;
  int32_t length = stack[1].ival;
  
  void* obj_socket_strerror = socket_strerror_string(env, stack, error_number, length);
  
  stack[0].oval = obj_socket_strerror;
  
  return 0;
}

static const char* socket_strerror(SPVM_ENV* env, SPVM_VALUE* stack, int32_t error_number, int32_t length) {
  void* obj_socket_strerror = socket_strerror_string(env, stack, error_number, length);
  
  const char* ret_socket_strerror = NULL;
  if (obj_socket_strerror) {
    ret_socket_strerror = env->get_chars(env, stack, obj_socket_strerror);
  }
  
  return ret_socket_strerror;
}

static const char* FILE_NAME = "IO/Util.c";

int32_t SPVM__IO__Util__sockatmark(SPVM_ENV* env, SPVM_VALUE* stack) {
#ifdef _WIN32
    env->die(env, stack, "[Not Supported]sockatmark is not supported on this system(_WIN32)", FILE_NAME, __LINE__);
    return SPVM_NATIVE_C_CLASS_ID_ERROR_NOT_SUPPORTED;
#else
  
  int32_t sockfd = stack[0].ival;
  
  int32_t status = sockatmark(sockfd);
  
  if (status == -1) {
    env->die(env, stack, "[System Error]shutdown failed: %s", socket_strerror(env, stack, socket_errno(), 0), FILE_NAME, __LINE__);
    return SPVM_NATIVE_C_CLASS_ID_ERROR_SYSTEM;
  }
  
  stack[0].ival = status;
  
  return 0;
#endif
}

int32_t SPVM__IO__Util__sendto(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  int32_t sockfd = stack[0].ival;

  void* obj_buf = stack[1].oval;
  
  if (!obj_buf) {
    return env->die(env, stack, "The $buf must be defined", FILE_NAME, __LINE__);
  }
  
  const char* buf = env->get_chars(env, stack, obj_buf);
  
  int32_t len = stack[2].ival;
  
  int32_t flags = stack[3].ival;

  void* obj_addr = stack[4].oval;
  
  if (!obj_addr) {
    return env->die(env, stack, "The $addr must be defined", FILE_NAME, __LINE__);
  }
  
  const struct sockaddr* addr = env->get_pointer(env, stack, obj_addr);
  
  int32_t addrlen = stack[5].ival;

  int32_t bytes_length = sendto(sockfd, buf, len, flags, addr, addrlen);
  
  if (bytes_length == -1) {
    env->die(env, stack, "[System Error]sendto failed: %s", socket_strerror(env, stack, socket_errno(), 0), FILE_NAME, __LINE__);
    return SPVM_NATIVE_C_CLASS_ID_ERROR_SYSTEM;
  }
  
  stack[0].ival = bytes_length;
  
  return 0;
}

int32_t SPVM__IO__Util__SO_BROADCAST(SPVM_ENV* env, SPVM_VALUE* stack) {

#ifdef SO_BROADCAST
  stack[0].ival = SO_BROADCAST;
  return 0;
#else
  env->die(env, stack, "SO_BROADCAST is not defined on this system", FILE_NAME, __LINE__);
  return SPVM_NATIVE_C_CLASS_ID_ERROR_NOT_SUPPORTED;
#endif
  
}

int32_t SPVM__IO__Util__IPPROTO_ICMP(SPVM_ENV* env, SPVM_VALUE* stack) {

#ifdef IPPROTO_ICMP
  stack[0].ival = IPPROTO_ICMP;
  return 0;
#else
  env->die(env, stack, "IPPROTO_ICMP is not defined on this system", FILE_NAME, __LINE__);
  return SPVM_NATIVE_C_CLASS_ID_ERROR_NOT_SUPPORTED;
#endif
  
}
