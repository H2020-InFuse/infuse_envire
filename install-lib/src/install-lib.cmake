
if(TARGET ${LIBRARY_NAME})

## Generate and install a .pc file for installation (not the same as the one for compilation)
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
    configure_file(${CMAKE_CURRENT_LIST_DIR}/template.pc.in ${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/${LIBRARY_NAME}.pc @ONLY)")

## Mark executables and/or libraries for installation
install(TARGETS ${LIBRARY_NAME}
  ARCHIVE DESTINATION lib/static
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)
else()

## Install pure header library
message(STATUS "Installing pure header library")
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
    configure_file(${CMAKE_CURRENT_LIST_DIR}/template-header-lib.pc.in ${CMAKE_INSTALL_PREFIX}/lib/pkgconfig/${LIBRARY_NAME}.pc @ONLY)")

endif()


