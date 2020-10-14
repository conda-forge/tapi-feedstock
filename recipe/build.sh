#!/bin/bash

mkdir build
cd build

# TODO: Fix this in a better way.
CXXFLAGS="$CXXFLAGS -I$SRC_DIR/src/llvm/projects/clang/include -I$SRC_DIR/build/projects/clang/include"

cmake ${CMAKE_ARGS} \
    -G Ninja \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_ASM_COMPILER=$CC \
    -DCMAKE_LIBTOOL=$LIBTOOL \
    -DCMAKE_AR=$AR \
    -DCMAKE_NM=$NM \
    -DCMAKE_RANLIB=$RANLIB \
    -DCMAKE_STRIP=$STRIP \
    -DCMAKE_INSTALL_NAME_TOOL=$INSTALL_NAME_TOOL \
    -DTAPI_REPOSITORY_STRING=tapi-${PKG_VERSION} \
    -DLLVM_TARGETS_TO_BUILD=host \
    -DTAPI_FULL_VERSION=11.0.0 \
    -DLLVM_INCLUDE_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    $SRC_DIR/src/llvm

set +e
ninja clangBasic -j${CPU_COUNT}
ninja clangBasic -j${CPU_COUNT}
ninja libtapi -j${CPU_COUNT}
ninja libtapi -j${CPU_COUNT}
set -e
ninja install-libtapi install-tapi-headers -j${CPU_COUNT}
