#!/bin/bash

#exit if error
set -e

prefix=
while [ "$1" != "" ]; do
    case $1 in
        -p | --prefix )           shift
                                prefix=$1
                                ;;
        * )                     echo "no --prefix defined"
                                exit 1
    esac
    shift
done

if [ ! -d "build" ]; then
	mkdir build
fi
cd build

cmake -DCMAKE_INSTALL_PREFIX=$prefix ../install-lib/
make install
source $prefix/setup.sh
rm -r *

cmake -DCMAKE_INSTALL_PREFIX=$prefix ../base-logging/
make install
source $prefix/setup.sh
rm -r *

cmake -DCMAKE_INSTALL_PREFIX=$prefix ../base-types/
make install
source $prefix/setup.sh
rm -r *

cmake -DCMAKE_INSTALL_PREFIX=$prefix ../base-boost_serialization/
make install
source $prefix/setup.sh
rm -r *

cmake -DCMAKE_INSTALL_PREFIX=$prefix ../envire-core/
make install
source $prefix/setup.sh
rm -r *

cd ..
rm -r build
