cmake_minimum_required(VERSION 3.1)

project(CMakeCppWarnings
  VERSION 0.1.0
  LANGUAGES CXX
  DESCRIPTION "C++ project for testing the cpp_warnings CMake module"
  HOMEPAGE_URL https://github.com/joseasoler/cmake_cpp_warnings
  )

# Set the standard used by this project.
set(CMAKE_CXX_STANDARD 98)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
# Disable non-standard extensions by default.
set(CMAKE_CXX_EXTENSIONS OFF)

include(cmake/cpp_warnings.cmake)

add_executable(CMakeCppWarnings src/main.cpp)
target_compile_options(CMakeCppWarnings PRIVATE ${PROJECT_WARNING_FLAGS})
