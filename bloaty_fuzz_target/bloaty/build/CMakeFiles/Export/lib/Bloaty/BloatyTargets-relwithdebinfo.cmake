#----------------------------------------------------------------
# Generated CMake target import file for configuration "RelWithDebInfo".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Bloatybloaty" for configuration "RelWithDebInfo"
set_property(TARGET Bloatybloaty APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(Bloatybloaty PROPERTIES
  IMPORTED_LOCATION_RELWITHDEBINFO "${_IMPORT_PREFIX}/bin/bloaty"
  )

list(APPEND _IMPORT_CHECK_TARGETS Bloatybloaty )
list(APPEND _IMPORT_CHECK_FILES_FOR_Bloatybloaty "${_IMPORT_PREFIX}/bin/bloaty" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
