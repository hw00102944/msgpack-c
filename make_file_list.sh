#!/bin/bash

find include -name "*.h" | sed -e 's/\s\+/\n/g' | sort > c_headers.tmp
find include -name "*.hpp" | sed -e 's/\s\+/\n/g' | sort > cpp_headers.tmp

echo '# .h files
LIST (APPEND msgpackc_HEADERS' >> Files.cmake
cat c_headers.tmp | sed -e 's/^/    /g' >> Files.cmake
echo -e ')\n' >> Files.cmake

echo '# .hpp files
LIST (APPEND msgpackc_HEADERS' >> Files.cmake
cat cpp_headers.tmp | sed -e 's/^/    /g' >> Files.cmake
echo ')' >> Files.cmake

rm -f srcs.tmp c_headers.tmp cpp_headers.tmp
