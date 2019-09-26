# This module defines a set of warnings that can be enabled on a target by using the target_enable_warnings function.
# By default this set includes as many reasonable warnings as possible. Only warnings that are supported by the compiler
# version in use will be enabled. The list of warnings is meant to be adapted and tweaked as needed for each project.
# For more details see https://lefticus.gitbooks.io/cpp-best-practices/content/02-Use_the_Tools_Available.html

include_guard(GLOBAL)

option(WARNINGS_AS_ERRORS "Targets using target_enable_warnings will treat warnings as errors." OFF)

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  option(CLANG_ENABLE_ALL_WARNINGS "target_enable_warnings will enable all available warnings when using Clang" OFF)
endif ()

# When using MSVC in CMake 3.14 and below, warning flags like /W3 are added to CMAKE_CXX_FLAGS by default.
if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" AND "${CMAKE_CXX_FLAGS}" MATCHES "/W3")
  message("-- Disabling /W3 flag added by default by CMake. See policy CMP0092.")
  string(REGEX REPLACE "/W3" "" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endif ()

function(target_enable_warnings TARGET)
  if (CLANG_ENABLE_ALL_WARNINGS)
    target_compile_options(${TARGET} PRIVATE
      -Weverything # Enables every Clang warning.
      )
  elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    # Warnings present on all supported versions of GCC and Clang.
    target_compile_options(${TARGET} PRIVATE
      -Wall                         # Enable most warning messages.
      -Wextra                       # Print extra warnings.
      -pedantic                     # Issue warnings needed for strict compliance to the standard.
      -Wcast-align                  # Warn about pointer casts which increase alignment.
      -Wconversion                  # Warn for implicit type conversions that may change a value.
      -Wformat=2                    # Warn about printf/scanf/strftime/strfmon format string anomalies.
      -Wnon-virtual-dtor            # Warn about non-virtual destructors.
      -Wold-style-cast              # Warn if a C-style cast is used in a program.
      -Woverloaded-virtual          # Warn about overloaded virtual function names.
      -Wsign-conversion             # Warn for implicit conversions between signed and unsigned integers.
      -Wshadow                      # Warn when one variable shadows another.
      -Wunused                      # Enable all -Wunused- warnings.
      )
    # Enable additional warnings depending on the compiler and compiler version in use.
    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
      target_compile_options(${TARGET} PRIVATE
        -Wlogical-op                # Warn when a logical operator is always evaluating to true or false.
        )
      if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.6)
        target_compile_options(${TARGET} PRIVATE
          -Wdouble-promotion        # Warn about implicit conversions from "float" to "double".
          )
      endif ()
      if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.8)
        target_compile_options(${TARGET} PRIVATE
          -Wuseless-cast            # Warn about useless casts.
          )
      endif ()
      if (NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 6))
        target_compile_options(${TARGET} PRIVATE
          -Wduplicated-cond         # Warn about duplicated conditions in an if-else-if chain.
          -Wmisleading-indentation  # Warn when indentation does not reflect the block structure.
          -Wnull-dereference        # Dereferencing a pointer may lead to erroneous or undefined behavior.
          )
      endif ()
      if (NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 7)
        target_compile_options(${TARGET} PRIVATE
          -Wduplicated-branches     # Warn about duplicated branches in if-else statements.
          )
      endif ()
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
      target_compile_options(${TARGET} PRIVATE
        -Wdouble-promotion          # Warn about implicit conversions from "float" to "double".
        -Wnull-dereference          # Dereferencing a pointer may lead to erroneous or undefined behavior.
        -Wno-unknown-warning-option # Ignore unknown warning options.
        )
    endif ()
  elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${TARGET} PRIVATE
      /permissive- # Specify standards conformance mode to the compiler.
      /W4          # Enable level 4 warnings.
      /w14062      # Enumerator 'identifier' in a switch of enum 'enumeration' is not handled.
      /w14242      # The types are different, possible loss of data. The compiler makes the conversion.
      /w14254      # A larger bit field was assigned to a smaller bit field, possible loss of data.
      /w14263      # Member function does not override any base class virtual member function.
      /w14265      # 'class': class has virtual functions, but destructor is not virtual.
      /w14287      # 'operator': unsigned/negative constant mismatch.
      /w14289      # Loop control variable is used outside the for-loop scope.
      /w14296      # 'operator': expression is always false.
      /w14311      # 'variable' : pointer truncation from 'type' to 'type'.
      /w14545      # Expression before comma evaluates to a function which is missing an argument list.
      /w14546      # Function call before comma missing argument list.
      /w14547      # Operator before comma has no effect; expected operator with side-effect.
      /w14549      # Operator before comma has no effect; did you intend 'operator2'?
      /w14555      # Expression has no effect; expected expression with side-effect.
      /w14619      # #pragma warning: there is no warning number 'number'.
      /w14640      # 'instance': construction of local static object is not thread-safe.
      /w14826      # Conversion from 'type1' to 'type2' is sign-extended.
      /w14905      # Wide string literal cast to 'LPSTR'.
      /w14906      # String literal cast to 'LPWSTR'.
      /w14928      # Illegal copy-initialization; applied more than one user-defined conversion.
      )
  endif ()

  # Enable warnings as errors.
  if (WARNINGS_AS_ERRORS)
    if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
      target_compile_options(${TARGET} PRIVATE -Werror)
    elseif (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
      target_compile_options(${TARGET} PRIVATE /WX)
    endif ()
  endif ()
endfunction()
