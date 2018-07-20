
## Generate and install a .pc file for installation (not the same as the one for compilation)
install(CODE "
    set(LIBRARY_NAME ${LIBRARY_NAME})
    set(PROJECT_VERSION ${PROJECT_VERSION})
    set(DEPENDENCIES \"${DEPENDENCIES}\")
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
