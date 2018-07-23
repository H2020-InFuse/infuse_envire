cmake_minimum_required (VERSION 3.5)
project (boost_serialization VERSION 0.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
)

set(HEADERS
#src/BaseNumeric.hpp
    src/BaseTypes.hpp
    src/BoostTypes.hpp
#src/ClassVersion.hpp
    src/DynamicSizeSerialization.hpp
    src/EigenTypes.hpp
)

find_package(PkgConfig REQUIRED)

pkg_check_modules(BASE_TYPES REQUIRED base-types)
foreach(includepath ${BASE_TYPES_INCLUDE_DIRS})
    include_directories(${includepath})
endforeach()
foreach(librarypath ${BASE_TYPES_LIBRARY_DIRS})
    link_directories(${librarypath})
endforeach()

set(LIBRARY_NAME boost_serialization)
set(DEPENDENCIES "base-types")

set(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH})
message(STATUS ${CMAKE_MODULE_PATH})
include(install-lib)



