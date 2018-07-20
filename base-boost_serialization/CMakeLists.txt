cmake_minimum_required (VERSION 3.5)
project (boost_serialization VERSION 0.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
)

set(HEADERS
#src/BaseNumeric.hpp
#src/BaseTypes.hpp
src/BoostTypes.hpp
#src/ClassVersion.hpp
#src/DynamicSizeSerialization.hpp
#src/EigenTypes.hpp
)

pkg_check_modules(BASE_LOGGING REQUIRED base-logging)
foreach(includepath ${BASE_LOGGING_INCLUDE_DIRS})
    include_directories(${includepath})
endforeach()
foreach(librarypath ${BASE_LOGGING_LIBRARY_DIRS})
    link_directories(${librarypath})
endforeach()

set(LIBRARY_NAME boost_serialization)
set(DEPENDENCIES "base-logging")
add_library(${LIBRARY_NAME} SHARED ${SOURCES})
target_link_libraries(${LIBRARY_NAMES}
    ${BASE_LOGGING_LIBRARIES}
)

set(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH})
message(STATUS ${CMAKE_MODULE_PATH})
include(install-lib)



