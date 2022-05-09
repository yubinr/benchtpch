project(dbgen)

set(DATABASE "DB2" CACHE STRING "Command language dialect to target with the qgen query generator (\"DATABASE\"")
set_property(CACHE DATABASE PROPERTY STRINGS INFORMIX DB2 TDAT SQLSERVER SYBASE ORACLE VECTORWISE POSTGRES)

set(MACHINE LINUX CACHE STRING "Platform to target (\"MACHINE\")")
set_property(CACHE MACHINE PROPERTY STRINGS ATT HP IBM ICL MVS SGI SUN U2200 VMS LINUX WIN32 MAC)

set(WORKLOAD TPCH CACHE STRING "Choice of benchmark / query workload (\"WORKLOAD\")")
set_property(CACHE WORKLOAD PROPERTY STRINGS TPCH)

set(EOL_HANDLING OFF CACHE BOOL "Skip separator after the last field in generated lines?")

set(CMAKE_CXX_FLAGS "")
set(CMAKE_C_FLAGS "")
add_definitions(-w)

add_executable(dbgen
    bcd2.c
    bm_utils.c
    build.c
    driver.c
    load_stub.c
    permute.c
    print.c
    rnd.c
    rng64.c
    speed_seed.c
    text.c
)
add_executable(qgen
    bm_utils.c
    build.c
    permute.c
    qgen.c
    rnd.c
    rng64.c
    speed_seed.c
    text.c
    varsub.c
)

set_property(
    TARGET dbgen qgen
    APPEND PROPERTY COMPILE_DEFINITIONS
    DBNAME="dss"
    ${MACHINE}
    ${DATABASE}
    ${WORKLOAD}
    RNG_TEST_FILE_OFFSET_BITS=64
)

if (EOL_HANDLING)
    set_property(
        TARGET dbgen qgen
        APPEND PROPERTY COMPILE_DEFINITIONS EOL_HANDLING
    )
endif()

set_property(
    TARGET dbgen qgen
    APPEND PROPERTY COMPILE_OPTIONS -Wall
)

add_custom_command(TARGET qgen
    # Run after all other rules within the target have been executed
    POST_BUILD
    COMMAND cp ${CMAKE_BINARY_DIR}/qgen ${CMAKE_SOURCE_DIR}/../
    COMMENT "Copy qgen to output folder"
    VERBATIM
)

add_custom_command(TARGET dbgen
    # Run after all other rules within the target have been executed
    POST_BUILD
    COMMAND cp ${CMAKE_BINARY_DIR}/dbgen ${CMAKE_SOURCE_DIR}/../
    COMMENT "Copy dbgen to output folder"
    VERBATIM
)

file(COPY dists.dss dss.ddl DESTINATION ${CMAKE_SOURCE_DIR}/../)
