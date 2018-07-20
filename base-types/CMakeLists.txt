cmake_minimum_required (VERSION 3.5)
project (base-types VERSION 0.1)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -Wall")

set(SOURCES
#src/Angle.cpp
#src/CircularBuffer.cpp
#src/Deprecated.cpp
#src/JointLimitRange.cpp
#src/JointLimits.cpp
#src/JointState.cpp
#src/JointsTrajectory.cpp
#src/JointTransform.cpp
#src/Logging.cpp
#src/Matrix.cpp
#src/NamedVector.cpp
#src/Point.cpp
src/Pose.cpp
#src/Pressure.cpp
#src/Singleton.cpp
#src/Spline.cpp
#src/Temperature.cpp
    src/Time.cpp
#src/TimeMark.cpp
#src/Timeout.cpp
#src/Trajectory.cpp
    src/TransformWithCovariance.cpp
#src/TwistWithCovariance.cpp
#src/Waypoint.cpp
#src/Wrench.cpp
#src/commands/Joints.cpp
#src/commands/LinearAngular6DCommand.cpp
#src/commands/Motion2D.cpp
#src/commands/Speed6D.cpp
#src/logging/logging_iostream_style.h
#src/logging/logging_printf_style.h
#src/samples/BodyState.cpp
#src/samples/CommandSamples.cpp
#src/samples/DepthMap.cpp
#src/samples/DepthMap.cpp
#src/samples/DistanceImage.cpp
#src/samples/Frame.cpp
#src/samples/IMUSensors.cpp
#src/samples/Joints.cpp
#src/samples/LaserScan.cpp
#src/samples/Pointcloud.cpp
#src/samples/PoseWithCovariance.cpp
#src/samples/PoseWithCovariance.cpp
#src/samples/Pressure.cpp
#src/samples/RigidBodyAcceleration.cpp
#src/samples/RigidBodyState.cpp
#src/samples/SonarBeam.cpp
#src/samples/Sonar.cpp
#src/samples/SonarScan.cpp
#src/samples/Wrenches.cpp
#src/samples/Wrench.cpp
)

set(HEADERS
#src/Angle.hpp
#src/CircularBuffer.hpp
#src/Deprecated.hpp
src/Eigen.hpp
src/Float.hpp
#src/JointLimitRange.hpp
#src/JointLimits.hpp
#src/JointState.hpp
#src/JointsTrajectory.hpp
#src/JointTransform.hpp
#src/Logging.hpp
#src/Matrix.hpp
#src/NamedVector.hpp
#src/Point.hpp
src/Pose.hpp
#src/Pressure.hpp
#src/Singleton.hpp
#src/Spline.hpp
#src/Temperature.hpp
    src/Time.hpp
#src/TimeMark.hpp
#src/Timeout.hpp
#src/Trajectory.hpp
    src/TransformWithCovariance.hpp
#src/TwistWithCovariance.hpp
#src/Waypoint.hpp
#src/Wrench.hpp
#src/commands/Joints.hpp
#src/commands/LinearAngular6DCommand.hpp
#src/commands/Motion2D.hpp
#src/commands/Speed6D.hpp
#src/logging/logging_iostream_style.h
#src/logging/logging_printf_style.h
#src/samples/BodyState.hpp
#src/samples/CommandSamples.hpp
#src/samples/DepthMap.cpp
#src/samples/DepthMap.hpp
#src/samples/DistanceImage.hpp
#src/samples/Frame.hpp
#src/samples/IMUSensors.hpp
#src/samples/Joints.hpp
#src/samples/LaserScan.hpp
#src/samples/Pointcloud.hpp
#src/samples/PoseWithCovariance.cpp
#src/samples/PoseWithCovariance.hpp
#src/samples/Pressure.hpp
#src/samples/RigidBodyAcceleration.hpp
#src/samples/RigidBodyState.hpp
#src/samples/SonarBeam.hpp
#src/samples/Sonar.hpp
#src/samples/SonarScan.hpp
#src/samples/Wrenches.hpp
#src/samples/Wrench.hpp
#src/templates/TimeStamped.hpp
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



