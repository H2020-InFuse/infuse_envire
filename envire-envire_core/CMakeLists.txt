cmake_minimum_required (VERSION 3.5)
project (envire-core VERSION 0.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
    src/events/GraphEvent.cpp
    src/events/GraphEventDispatcher.cpp
    src/events/GraphEventPublisher.cpp
#src/events/GraphEventQueue.cpp
    src/events/GraphEventSubscriber.cpp
    src/graph/EnvireGraph.cpp
    src/graph/Path.cpp
    src/graph/TreeView.cpp
#src/items/AlignedBoundingBox.cpp
src/items/ItemBase.cpp
#src/items/ItemMetadata.cpp
#src/plugin/ClassLoader.cpp
#src/serialization/Serialization.cpp
src/util/Demangle.cpp
)

set(HEADERS
    src/events/GraphEvent.hpp
    src/events/GraphEventDispatcher.hpp
    src/events/GraphEventPublisher.hpp
#src/events/GraphEventQueue.hpp
    src/events/GraphEventSubscriber.hpp
    src/events/GraphItemEventDispatcher.hpp
    src/events/EdgeEvents.hpp
    src/events/FrameEvents.hpp
    src/events/GraphEventExceptions.hpp
    src/events/ItemAddedEvent.hpp
    src/events/ItemRemovedEvent.hpp
    src/graph/EnvireGraph.hpp
#src/graph/GraphDrawing.hpp
    src/graph/GraphExceptions.hpp
    src/graph/Graph.hpp
    src/graph/GraphTypes.hpp
    src/graph/GraphVisitors.hpp
    src/graph/Path.hpp
    src/graph/TransformGraph.hpp
    src/graph/TreeView.hpp
#src/items/AlignedBoundingBox.hpp
#src/items/BoundingVolume.hpp
    src/items/Environment.hpp
src/items/Frame.hpp
src/items/ItemBase.hpp
#src/items/Item.hpp
#src/items/ItemMetadata.hpp
#src/items/RandomGenerator.hpp
#src/items/SpatialItem.hpp
#src/items/SpatioTemporal.hpp
src/items/Transform.hpp
#src/plugin/ClassLoader.hpp
#src/plugin/Plugin.hpp
#src/serialization/BinaryBufferHelper.hpp
#src/serialization/ItemHeader.hpp
src/serialization/SerializableConcept.hpp
#src/serialization/SerializationHandle.hpp
#src/serialization/Serialization.hpp
#src/serialization/SerializationRegistration.hpp
#src/util/Exceptions.hpp
src/util/Demangle.hpp
)

pkg_check_modules(BASE_LOGGING REQUIRED base-logging)
foreach(includepath ${BASE_LOGGING_INCLUDE_DIRS})
    include_directories(${includepath})
endforeach()
foreach(librarypath ${BASE_LOGGING_LIBRARY_DIRS})
    link_directories(${librarypath})
endforeach()

set(LIBRARY_NAME envire-core)
set(DEPENDENCIES "base-logging")
add_library(${LIBRARY_NAME} SHARED ${SOURCES})
target_link_libraries(${LIBRARY_NAMES}
    ${BASE_LOGGING_LIBRARIES}
)

set(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH})
message(STATUS ${CMAKE_MODULE_PATH})
include(install-lib)



