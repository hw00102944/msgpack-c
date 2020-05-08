FIND_PACKAGE (CJSON)
LIST (APPEND exec_PROGRAMS
    lib_buffer_unpack.c
    simple_c.c
    speed_test_uint32_array.c
    speed_test_uint64_array.c
    user_buffer_unpack.c
)

IF (CJSON_FOUND)
    LIST (APPEND exec_PROGRAMS jsonconv.c)
ENDIF ()

FOREACH (source_file ${exec_PROGRAMS})
    GET_FILENAME_COMPONENT (source_file_we ${source_file} NAME_WE)
    ADD_EXECUTABLE (
        ${source_file_we}
        ${source_file}
    )
    TARGET_LINK_LIBRARIES (${source_file_we}
        msgpackc
    )
    IF ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
        SET_PROPERTY (TARGET ${source_file_we} APPEND_STRING PROPERTY COMPILE_FLAGS " -Wall -Wextra")
    ENDIF ()

    IF ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
        SET_PROPERTY (TARGET ${source_file_we} APPEND_STRING PROPERTY COMPILE_FLAGS " -Wno-mismatched-tags")
    ENDIF ()

    IF ("${CMAKE_C_COMPILER_ID}" STREQUAL "MSVC")
        IF (CMAKE_C_FLAGS MATCHES "/W[0-4]")
            STRING(REGEX REPLACE "/W[0-4]" "/W3 /WX" CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
        ELSE ()
            SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /W3 /WX")
        ENDIF ()
    ENDIF ()
ENDFOREACH ()

IF (CJSON_FOUND)
    TARGET_LINK_LIBRARIES (jsonconv ${CJSON_LIBRARYS})
    TARGET_INCLUDE_DIRECTORIES(jsonconv PRIVATE ${CJSON_INCLUDE_DIR})
ENDIF ()

#copy test files
    file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/inputs")
    file(GLOB test_files "inputs/*")
    file(COPY ${test_files} DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/inputs/")
