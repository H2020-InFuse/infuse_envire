cmake_minimum_required (VERSION 3.5)
project (install-lib VERSION 0.1)

install(FILES src/setup.sh
        DESTINATION .)
install(FILES src/install-lib.cmake src/template.pc.in
    DESTINATION share/cmake/Modules)

