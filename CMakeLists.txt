cmake_minimum_required (VERSION 3.5)
project (infuse_envire VERSION 0.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
    src/events/GraphEvent.cpp
    src/events/GraphEventDispatcher.cpp
    src/events/GraphEventPublisher.cpp
    src/events/GraphEventSubscriber.cpp
    src/graph/EnvireGraph.cpp
    src/graph/Path.cpp
    src/graph/TreeView.cpp
    src/items/ItemBase.cpp
    src/serialization/Serialization.cpp
    src/util/Demangle.cpp
    src/base-logging/logging/logging_printf_style.cpp
    src/base-types/Angle.cpp
    src/base-types/Pose.cpp
    src/base-types/Time.cpp
    src/base-types/TransformWithCovariance.cpp
)

set(HEADERS
    src/events/GraphEvent.hpp
    src/events/GraphEventDispatcher.hpp
    src/events/GraphEventPublisher.hpp
    src/events/GraphEventSubscriber.hpp
    src/events/GraphItemEventDispatcher.hpp
    src/events/EdgeEvents.hpp
    src/events/FrameEvents.hpp
    src/events/GraphEventExceptions.hpp
    src/events/ItemAddedEvent.hpp
    src/events/ItemRemovedEvent.hpp
    src/graph/EnvireGraph.hpp
    src/graph/GraphExceptions.hpp
    src/graph/Graph.hpp
    src/graph/GraphTypes.hpp
    src/graph/GraphVisitors.hpp
    src/graph/Path.hpp
    src/graph/TransformGraph.hpp
    src/graph/TreeView.hpp
    src/items/Environment.hpp
    src/items/Frame.hpp
    src/items/ItemBase.hpp
    src/items/RandomGenerator.hpp
    src/items/Transform.hpp
    src/serialization/BinaryBufferHelper.hpp
    src/serialization/ItemHeader.hpp
    src/serialization/SerializableConcept.hpp
    src/serialization/SerializationHandle.hpp
    src/serialization/Serialization.hpp
    src/util/Demangle.hpp
    src/base-boost_serialization/BaseTypes.hpp
    src/base-boost_serialization/BoostTypes.hpp
    src/base-boost_serialization/DynamicSizeSerialization.hpp
    src/base-boost_serialization/EigenTypes.hpp
    src/base-logging/Logging.hpp
    src/base-logging/Singleton.hpp
    src/base-logging/logging/logging_iostream_style.h
    src/base-logging/logging/logging_printf_style.h
    src/base-logging/logging/terminal_colors.h
    src/base-types/Angle.hpp
    src/base-types/Eigen.hpp
    src/base-types/Float.hpp
    src/base-types/Pose.hpp
    src/base-types/Time.hpp
    src/base-types/TransformWithCovariance.hpp
)

find_package(PkgConfig)
pkg_check_modules(EIGEN3 REQUIRED eigen3)
foreach(includepath ${EIGEN3_INCLUDE_DIRS})
    include_directories(${includepath})
endforeach()
foreach(librarypath ${EIGEN3_LIBRARY_DIRS})
    link_directories(${librarypath})
endforeach()

find_package(Boost COMPONENTS serialization filesystem system)
foreach(includepath ${Boost_INCLUDE_DIRS})
    set(PKGCONFIG_CFLAGS "${PKGCONFIG_CFLAGS} -I${includepath}")
    include_directories(${includepath})
endforeach()
foreach(librarypath ${Boost_LIBRARY_DIRS})
    set(PKGCONFIG_LIBS "${PKGCONFIG_LIBS} -L${librarypath}")
    link_directories(${librarypath})
endforeach()
foreach(library ${Boost_LIBRARIES})
    set(PKGCONFIG_LIBS "${PKGCONFIG_LIBS} ${library}")
endforeach()

message(STATUS ${PKGCONFIG_CFLAGS})
message(STATUS ${PKGCONFIG_LIBS})


set(LIBRARY_NAME infuse_envire)
set(PKGCONFIG_REQUIRES "eigen3")
add_library(${LIBRARY_NAME} SHARED ${SOURCES})
target_link_libraries(${LIBRARY_NAME}
    ${Boost_LIBRARIES}
    ${EIGEN3_LIBRARIES}
)


# installation process (copy header files, generates a .pc file, install libraries)
install(CODE "
    set(LIBRARY_NAME ${LIBRARY_NAME})
    set(PROJECT_VERSION ${PROJECT_VERSION})
    set(PKGCONFIG_REQUIRES \"${PKGCONFIG_REQUIRES}\")
    set(PKGCONFIG_LIBS \"${PKGCONFIG_LIBS}\")
    set(PKGCONFIG_CFLAGS \"${PKGCONFIG_CFLAGS}\")
    foreach(header ${HEADERS})
        file(RELATIVE_PATH rpath ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_SOURCE_DIR}/\${header})
        get_filename_component(rpath \${rpath} DIRECTORY)
        file(INSTALL ${CMAKE_CURRENT_SOURCE_DIR}/\${header} DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${LIBRARY_NAME}/\${rpath})
    endforeach()
    message(STATUS \"Installing: ${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/${LIBRARY_NAME}.pc\")
    configure_file(${CMAKE_SOURCE_DIR}/${LIBRARY_NAME}.pc.in ${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/${LIBRARY_NAME}.pc @ONLY)")

install(TARGETS ${LIBRARY_NAME}
  LIBRARY DESTINATION lib
)

