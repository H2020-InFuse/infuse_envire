# Add $ENVIRE_INSTALL_PREFIX to env before using this script
# default location ${HOME}/Envire
if [[ -z "$ENVIRE_INSTALL_PREFIX" ]]; then
    ENVIRE_INSTALL_PREFIX=${HOME}/Envire
fi
echo "Installation folder:$ENVIRE_INSTALL_PREFIX"

# Add $ENVIRE_INSTALL_PREFIX to env and source $ENVIRE_INSTALL_PREFIX/envire_env.sh prior to use envire

# Exit immediately if a simple command exits with a nonzero exit value.
set -e

# Get the directory of the current script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d "${ENVIRE_INSTALL_PREFIX}" ]; then
    mkdir -p $ENVIRE_INSTALL_PREFIX
fi

cp ${DIR}/envire_env.sh $ENVIRE_INSTALL_PREFIX
source $ENVIRE_INSTALL_PREFIX/envire_env.sh

# A temporary folder ./envire_install_tmp is created  to hold temporary source files
if [ ! -d "${HOME}/.envire_install_tmp" ]; then
    mkdir $HOME/.envire_install_tmp
fi
cd $HOME/.envire_install_tmp
echo "Temporary source folder:$(pwd)"

# Going into subshell
(

# This dependency could be installed with a packet manager (libgoogle-glog-dev)
if [ ! -d "glog" ]; then
    git clone https://github.com/google/glog.git
fi
cd glog
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX ..
make -j8
make install
cd ../../

if [ ! -d "base-cmake" ]; then
    git clone git://github.com/rock-core/base-cmake.git
fi
cd base-cmake
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX ..
make -j8
make install
cd ../../

if [ ! -d "base-logging" ]; then
    git clone https://github.com/rock-core/base-logging.git
fi
cd base-logging
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX ..
make -j8
make install
cd ../../

if [ ! -d "SISL" ]; then
    git clone https://github.com/SINTEF-Geometry/SISL.git
fi
cd SISL
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX -DCMAKE_CXX_FLAGS:STRING=-fPIC -DBUILD_SHARED_LIBS=ON ..
make -j8
make install
cd ../../

if [ ! -d "base-types" ]; then
    git clone git://github.com/rock-core/base-types.git
fi
cd base-types
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX -DCMAKE_CXX_FLAGS:STRING=-fPIC -DBINDINGS_RUBY=OFF -ROCK_VIZ_ENABLED=OFF .. 
# not sure if "-DCMAKE_CXX_FLAGS:STRING=-fPIC" mandatory in line above...
make install
cd ../../

if [ ! -d "tools-plugin_manager" ]; then
    git clone https://github.com/envire/tools-plugin_manager.git
fi
cd tools-plugin_manager
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX ..
make -j8
make install
cd ../../

if [ ! -d "base-numeric" ]; then
    git clone https://github.com/envire/base-numeric.git
fi
cd base-numeric
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX ..
make install
cd ../../

if [ ! -d "base-boost_serialization" ]; then
    git clone https://github.com/envire/base-boost_serialization.git
fi
cd base-boost_serialization
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX -DCMAKE_CXX_FLAGS:STRING=-std=c++11 ..
make -j8
make install
cd ../../

## Install envire-core (finally !!)
if [ ! -d "envire-envire_core" ]; then
    git clone https://github.com/envire/envire-envire_core.git
fi
cd envire-envire_core
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake -DCMAKE_INSTALL_PREFIX=$ENVIRE_INSTALL_PREFIX ..
make -j8
make install
cd ../../

)

