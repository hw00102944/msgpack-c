#!/bin/bash

last_commit_id=`git rev-parse HEAD`
echo the last commit id is: $last_commit_id

git_reset()
{
    if [[ $# -ge 1 ]] && [[ "$1" != "0" ]] ; then
        git reset --hard $last_commit_id
        echo "some errors occured, reset and exit."
        exit 1
    fi
}

entities_to_delete=(
    ci/build_cmake_embedded.sh
    example/c
    example/cmake
    include/msgpack/predef
    include/msgpack/preprocessor.hpp
    include/msgpack/preprocessor
    include/msgpack/v1/preprocessor.hpp
    include/msgpack.h
    include/msgpack/fbuffer.h
    include/msgpack/gcc_atomic.h
    include/msgpack/object.h
    include/msgpack/pack.h
    include/msgpack/pack_define.h
    include/msgpack/pack_template.h
    include/msgpack/predef.h
    include/msgpack/sbuffer.h
    include/msgpack/timestamp.h
    include/msgpack/unpack.h
    include/msgpack/unpack_template.h
    include/msgpack/util.h
    include/msgpack/version.h
    include/msgpack/vrefbuffer.h
    include/msgpack/zbuffer.h
    include/msgpack/zone.h
    msgpack_vc8.sln
    msgpack_vc8.vcproj
    msgpack-config.cmake.in
    msgpack.pc.in
    src
    test/fixint_c.cpp
    test/msgpack_c.cpp
    test/pack_unpack_c.cpp
    test/streaming_c.cpp
    .gitmodules
    external
    QUICKSTART-C.md
)
for entity in ${entities_to_delete[@]}; do
    git rm -r $entity
done

git commit -m 'remove C part

remove the following files or folders:
ci/build_cmake_embedded.sh
example/c
example/cmake
include/msgpack/predef
include/msgpack/preprocessor.hpp
include/msgpack/preprocessor
include/msgpack/v1/preprocessor.hpp
include/msgpack.h
include/msgpack/fbuffer.h
include/msgpack/gcc_atomic.h
include/msgpack/object.h
include/msgpack/pack.h
include/msgpack/pack_define.h
include/msgpack/pack_template.h
include/msgpack/predef.h
include/msgpack/sbuffer.h
include/msgpack/timestamp.h
include/msgpack/unpack.h
include/msgpack/unpack_template.h
include/msgpack/util.h
include/msgpack/version.h
include/msgpack/vrefbuffer.h
include/msgpack/zbuffer.h
include/msgpack/zone.h
msgpack_vc8.sln
msgpack_vc8.vcproj
msgpack-config.cmake.in
msgpack.pc.in
src
test/fixint_c.cpp
test/msgpack_c.cpp
test/pack_unpack_c.cpp
test/streaming_c.cpp
.gitmodules
external
QUICKSTART-C.md
'
git_reset $?

git mv include/msgpack/sysdep.h include/msgpack/sysdep.hpp
git mv include/msgpack/unpack_define.h include/msgpack/unpack_define.hpp
git mv include/msgpack/version_master.h include/msgpack/version_master.hpp
git commit -m 'rename include/msgpack/*.h to include/msgpack/*.hpp

include/msgpack/sysdep.h => include/msgpack/sysdep.hpp
include/msgpack/unpack_define.h => include/msgpack/unpack_define.hpp
include/msgpack/version_master.h => include/msgpack/version_master.hpp

Use `git log --follow include/msgpack/filename.hpp` to see full log
'
git_reset $?
