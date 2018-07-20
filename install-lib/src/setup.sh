# environment setup for utils
# Get the directory of the current script
export UTILS_INSTALL_PREFIX="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export PATH=$UTILS_INSTALL_PREFIX/bin:$PATH
export LD_LIBRARY_PATH=$UTILS_INSTALL_PREFIX/lib:$LD_LIBRARY_PATH
export PKG_CONFIG_PATH=$UTILS_INSTALL_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH
export CMAKE_MODULE_PATH=$UTILS_INSTALL_PREFIX/share/cmake/Modules
export GL_SHADER_PATH=$UTILS_INSTALL_PREFIX/share/gl/shaders


