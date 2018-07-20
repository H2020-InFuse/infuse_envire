cmake_minimum_required (VERSION 3.5)
project (base-logging VERSION 0.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
    src/logging/logging_printf_style.cpp
)

set(HEADERS
    src/Logging.hpp
    src/Singleton.hpp
    src/logging/logging_iostream_style.h
    src/logging/logging_printf_style.h
    src/logging/terminal_colors.h
)

set(LIBRARY_NAME base-logging)
set(DEPENDENCIES "")
add_library(${LIBRARY_NAME} SHARED ${SOURCES})

set(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH})
message(STATUS ${CMAKE_MODULE_PATH})
include(install-lib)



