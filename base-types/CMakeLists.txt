cmake_minimum_required (VERSION 3.5)
project (base-types VERSION 0.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
    src/events/GraphEvent.cpp
    src/events/GraphEventDispatcher.cpp
    src/events/GraphEventPublisher.cpp
    src/events/GraphEventQueue.cpp
    src/events/GraphEventSubscriber.cpp
)

set(HEADERS
    src/events/GraphEvent.hpp
    src/events/GraphEventDispatcher.hpp
    src/events/GraphEventPublisher.hpp
    src/events/GraphEventQueue.hpp
    src/events/GraphEventSubscriber.hpp
    src/events/GraphItemEventDispatcher.hpp
    src/events/EdgeEvents.hpp
    src/events/FrameEvents.hpp
    src/events/GraphEventExceptions.hpp
    src/events/ItemAddedEvent.hpp
    src/events/ItemRemovedEvent.hpp
)

pkg_check_modules(BASE_LOGGING REQUIRED base-logging)
foreach(includepath ${BASE_LOGGING_INCLUDE_DIRS})
    include_directories(${includepath})
endforeach()
foreach(librarypath ${BASE_LOGGING_LIBRARY_DIRS})
    link_directories(${librarypath})
endforeach()

set(LIBRARY_NAME base-types)
set(DEPENDENCIES "base-logging")
add_library(${LIBRARY_NAME} SHARED ${SOURCES})
target_link_libraries(${LIBRARY_NAMES}
    ${BASE_LOGGING_LIBRARIES}
)

set(CMAKE_MODULE_PATH $ENV{CMAKE_MODULE_PATH})
message(STATUS ${CMAKE_MODULE_PATH})
include(install-lib)



