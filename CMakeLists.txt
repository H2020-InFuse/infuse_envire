cmake_minimum_required (VERSION 3.5)
project (infuse_envire VERSION 0.1)

set(PKG_DESCRIPTION "Minimal version of DFKI EnVire")
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

find_package(Eigen3 REQUIRED)
find_package(Boost COMPONENTS serialization filesystem system)

include_directories(
    ${EIGEN3_INCLUDE_DIR}
    ${Boost_INCLUDE_DIR}
    )

add_library(${PROJECT_NAME} SHARED ${SOURCES})
target_link_libraries(${PROJECT_NAME}
    ${Boost_LIBRARIES}
    ${EIGEN3_LIBRARIES}
)


#Prepare .pc file
set(REQUIRED_COMPONENTS "eigen3")
set(ADDITIONAL_LINKS "")

foreach(library ${Boost_LIBRARIES})
    set(ADDITIONAL_LINKS "${ADDITIONAL_LINKS}${library} ")
endforeach()


include(GNUInstallDirs)
set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")

# This is exclusive for pkg-config
set(pkgconfig_install_dir "${CMAKE_INSTALL_LIBDIR}/pkgconfig")


set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")

# Configuration
set(version_config "${generated_dir}/${PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${PROJECT_NAME}Config.cmake")
set(pkgconfig_file "${generated_dir}/${PROJECT_NAME}.pc")
set(TARGETS_EXPORT_NAME "${PROJECT_NAME}Targets")


# Include module with fuctions:
#   * 'write_basic_package_version_file'
#   * 'configure_package_config_file'
include(CMakePackageConfigHelpers)


# Configure '<PROJECT-NAME>ConfigVersion.cmake'
# Uses:
#   * PROJECT_VERSION
write_basic_package_version_file(
  "${version_config}" COMPATIBILITY SameMajorVersion
)

# Configure '<PROJECT-NAME>Config.cmake'
# Uses variables:
#   * TARGETS_EXPORT_NAME
#   * PROJECT_NAME
#   * CMAKE_INSTALL_INCLUDEDIR
configure_package_config_file(
    "cmake/Config.cmake.in"
    "${project_config}"
    INSTALL_DESTINATION "${config_install_dir}"
    PATH_VARS
      CMAKE_INSTALL_INCLUDEDIR
)

# Configure '<PROJECT-NAME>.pc'
# Uses variables:
#   * PROJECT_NAME
#   * PROJECT_VERSION
#   * CMAKE_INSTALL_PREFIX
#   * CMAKE_INSTALL_LIBDIR
#   * CMAKE_INSTALL_INCLUDEDIR

configure_file(
    "cmake/pkgconfig.pc.cmakein"
    "${pkgconfig_file}" @ONLY
)

####
# Installation


# Targets:
#   * <prefix>/lib/lib${PROJECT_NAME}.so
#   * header location after install: <prefix>/include/${PROJECT_NAME}/*.h
#   * headers can be included by C++ code `#include <${PROJECT_NAME}/*.h>`
install(
    TARGETS ${PROJECT_NAME}
    EXPORT "${TARGETS_EXPORT_NAME}"
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}"
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

## This installs the headers while converving the folder structure. Somehow intall(DIRECTORY) does not work on robotpkg
install(CODE "
    foreach(header ${HEADERS})
        file(RELATIVE_PATH rpath ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_SOURCE_DIR}/\${header})
        get_filename_component(rpath \${rpath} DIRECTORY)
        file(INSTALL ${CMAKE_CURRENT_SOURCE_DIR}/\${header} DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME}/\${rpath})
    endforeach()"
)


# Config
#   * <prefix>/lib/cmake/${PROJECT_NAME}/${PROJECT_NAME}Config.cmake
#   * <prefix>/lib/cmake/${PROJECT_NAME}/${PROJECT_NAME}ConfigVersion.cmake
install(
    FILES "${project_config}" "${version_config}"
    DESTINATION "${config_install_dir}"
)



# Config
#   * <prefix>/lib/pkgconfig/${PROJECT_NAME}.pc
install(
    FILES "${pkgconfig_file}"
    DESTINATION "${pkgconfig_install_dir}")


# Config
#   * <prefix>/lib/cmake/infuse_cdff_types/infuse_cdff_typesTargets.cmake
install(
    EXPORT "${TARGETS_EXPORT_NAME}"
    DESTINATION "${config_install_dir}"
)
