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
    erb
    example/boost
    example/cpp03
    example/cpp11
    example/x3
    example/CMakeLists.txt
    fuzz
    include/msgpack/adaptor
    include/msgpack/predef.h
    include/msgpack/predef
    include/msgpack/preprocessor
    include/msgpack/v1
    include/msgpack/v2
    include/msgpack/v3
    include/msgpack/*.hpp
    include/msgpack.hpp
    .gitmodules
    external
    make_file_list.sh
    makedist.sh
    msgpack_vc8.sln
    msgpack_vc8.vcproj
    preprocess
    QUICKSTART-CPP.md
    .github/depends/boost.sh
    ci/build_regression.sh
)
for entity in ${entities_to_delete[@]}; do
    git rm -r $entity
done

# Remove all files excluding CMakeLists.txt, buffer.cpp and *_c.cpp in test folder
find test/* ! -name 'CMakeLists.txt' ! -name 'buffer.cpp' ! -name '*_c.cpp' | xargs git rm
git commit -m 'remove C++ part

remove the following files or folders:
erb
example/boost
example/cpp03
example/cpp11
example/x3
example/CMakeLists.txt
fuzz
include/msgpack/adaptor
include/msgpack/predef.h
include/msgpack/predef
include/msgpack/preprocessor
include/msgpack/v1
include/msgpack/v2
include/msgpack/v3
include/msgpack/*.hpp
include/msgpack.hpp
.gitmodules
external
make_file_list.sh
makedist.sh
msgpack_vc8.sln
msgpack_vc8.vcproj
preprocess
QUICKSTART-CPP.md
test/*.cpp exclude test/*_c.cpp
.github/depends/boost.sh
ci/build_regression.sh
'
git_reset $?

git mv example/c/* example/
rm -r example/c
git commit -m 'move exmple/c/* to example/*

example/c/cmake/CMakeLists.txt => example/cmake/CMakeLists.txt
example/c/lib_buffer_unpack.c => example/lib_buffer_unpack.c
example/c/simple_c.c => example/simple_c.c
example/c/speed_test_uint32_array.c => example/speed_test_uint32_array.c
example/c/speed_test_uint64_array.c => example/speed_test_uint64_array.c
example/c/user_buffer_unpack.c => example/user_buffer_unpack.c

Use `git log --follow example/xxx.c` to see full log
'
git_reset $?
