#!/usr/bin/env bash

# Build accellerators
apt-get install --yes icecc ccache

# Build accellerators.
ICECC=`which icecc`
CCACHE=`which ccache`

ICECC_BIN=/opt/icecc/bin
CCACHE_BIN=/opt/ccache/bin

rm -rf ${ICECC_BIN}
rm -rf ${CCACHE_BIN}

mkdir -p ${ICECC_BIN} ${CCACHE_BIN}

debs=
# GCC
for GCC_VER in 4.8 5 6 7 8
do
	debs+="gcc-${GCC_VER} g++-${GCC_VER} "
	ln -s ${ICECC} ${ICECC_BIN}/gcc-${GCC_VER}
	ln -s ${ICECC} ${ICECC_BIN}/g++-${GCC_VER}
	ln -s ${CCACHE} ${CCACHE_BIN}/gcc-${GCC_VER}
	ln -s ${CCACHE} ${CCACHE_BIN}/g++-${GCC_VER}
done

# LLVM
for CLANG_VER in 3.9 4.0 5.0 6.0 7 8
do
	debs+="clang-${CLANG_VER} "
	ln -s ${ICECC} ${ICECC_BIN}/clang-${CLANG_VER}
	ln -s ${ICECC} ${ICECC_BIN}/clang++-${CLANG_VER}
	ln -s ${CCACHE} ${CCACHE_BIN}/clang-${CLANG_VER}
	ln -s ${CCACHE} ${CCACHE_BIN}/clang++-${CLANG_VER}
done

apt-get install --yes ${debs}
