#!/bin/bash

mkdir build
cd build

cmake \
    -G Ninja \
    -C $SRC_DIR/tapi/cmake/caches/apple-tapi.cmake \
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
    $SRC_DIR/llvm

ninja install-distribution
