include_directories(../../../../include)

if(FIPS)
  add_executable(
    modulewrapper

    main.cc
    modulewrapper.cc
  )
  install(TARGETS modulewrapper)

  add_dependencies(modulewrapper global_target)

  target_link_libraries(modulewrapper crypto)
endif()
