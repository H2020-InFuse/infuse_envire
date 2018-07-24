cmake_minimum_required (VERSION 3.5)
project (base-types VERSION 0.1)

# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
    src/Angle.cpp
    src/Pose.cpp
    src/Time.cpp
    src/TransformWithCovariance.cpp
)

set(HEADERS
    src/Angle.hpp
    src/Eigen.hpp
    src/Float.hpp
    src/Pose.hpp
    src/Time.hpp
    src/TransformWithCovariance.hpp
)

find_package(PkgConfig)

pkg_check_modules(EIGEN3 REQUIRED eigen3)
foreach(includepath ${EIGEN3_INCLUDE_DIRS})
    include_directories(${includepath})
endforeach()
foreach(librarypath ${EIGEN3_LIBRARY_DIRS})
    link_directories(${librarypath})
endforeach()

set(LIBRARY_NAME base-types)
set(PKGCONFIG_REQUIRES "eigen3")
add_library(${LIBRARY_NAME} SHARED ${SOURCES})
target_link_libraries(${LIBRARY_NAME}
    ${EIGEN3_LIBRARIES}
)

set(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH})
message(STATUS ${CMAKE_MODULE_PATH})
include(install-lib)



