#!/bin/bash

set -eu

CURDIR="$(pwd)"
MYDIR="$(cd "$(dirname "$0")" && pwd)"
MYPARENT="$(dirname "${MYDIR}")"

source "${MYDIR}/common.sh"

check_args $@

PN="clang"
VER="$1"

P="${PN}-${VER}"
PREFIX="${MYPARENT}/software/Core/${PN}/${VER}"

# We don't use /tmp since this needs quite a bit of space
BUILDDIR="$(mktemp -d -p .)"

print_info "${P}" "${BUILDDIR}" "(multiple)" "(multiple)" "(multiple)" "${PREFIX}"

cd "${BUILDDIR}"
download_unpack http://releases.llvm.org/${VER}/llvm-${VER}.src.tar.xz               llvm-${VER}.src.tar.xz               llvm-${VER}.src 
download_unpack http://releases.llvm.org/${VER}/cfe-${VER}.src.tar.xz                cfe-${VER}.src.tar.xz                cfe-${VER}.src 
download_unpack http://releases.llvm.org/${VER}/compiler-rt-${VER}.src.tar.xz        compiler-rt-${VER}.src.tar.xz        compiler-rt-${VER}.src.tar.xz
download_unpack http://releases.llvm.org/${VER}/clang-tools-extra-${VER}.src.tar.xz  clang-tools-extra-${VER}.src.tar.xz  clang-tools-extra-${VER}.src

# Move to the proper directories
mv llvm-${VER}.src               llvm
mv cfe-${VER}.src                llvm/tools/clang
mv clang-tools-extra-${VER}.src  llvm/tools/clang/tools/extra
mv compiler-rt-${VER}.src        llvm/projects/compiler-rt

# Configure and build
mkdir build; cd build
cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_TARGETS_TO_BUILD="X86" ../llvm

# Build and install
make -j${PARALLEL}
make install

cd "${CURDIR}" 
rm -Rf "${BUILDDIR}"

# Symlink to the module file
mkdir -p "${MYPARENT}/modulefiles/Core/${PN}"
ln -s "../../_generic/${PN}.lua" "${MYPARENT}/modulefiles/Core/${PN}/${VER}.lua"
