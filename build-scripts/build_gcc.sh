#!/bin/bash

set -eu

CURDIR="$(pwd)"
MYDIR="$(cd "$(dirname "$0")" && pwd)"
MYPARENT="$(dirname "${MYDIR}")"

source "${MYDIR}/common.sh"

check_args $@

PN="gcc"
VER="$1"

P="${PN}-${VER}"
FILE="${P}.tar.gz"
DIR="${P}"
PREFIX="${MYPARENT}/software/Core/${PN}/${VER}"
URL="http://mirrors-usa.go-parts.com/gcc/releases/${P}/${FILE}"

# We don't use /tmp since this needs quite a bit of space
BUILDDIR="$(mktemp -d -p .)"

print_info "${P}" "${BUILDDIR}" "${FILE}" "${URL}" "${DIR}" "${PREFIX}"

cd "${BUILDDIR}"
download_unpack "${URL}" "${FILE}" "${DIR}"
cd "${DIR}"

# Download the prerequisites
bash contrib/download_prerequisites

# Configure
mkdir build; cd build
../configure --prefix="${PREFIX}" \
             --disable-multilib \
             --enable-languages=c,c++,fortran

# Build and install
make -j${PARALLEL}
make install

cd "${CURDIR}" 
rm -Rf "${BUILDDIR}"

# Symlink to the module file
mkdir -p "${MYPARENT}/modulefiles/Core/${PN}"
ln -s "../../_generic/${PN}.lua" "${MYPARENT}/modulefiles/Core/${PN}/${VER}.lua"
