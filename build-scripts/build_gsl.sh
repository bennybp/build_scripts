#!/bin/bash

set -eu

CURDIR="$(pwd)"
MYDIR="$(cd "$(dirname "$0")" && pwd)"
MYPARENT="$(dirname "${MYDIR}")"

source "${MYDIR}/common.sh"

check_args $@

PN="gsl"
VER="$1"
COMPILER="gcc/$(gcc --version | head -n 1 | awk '{print $NF}')"

P="${PN}-${VER}"
FILE="${P}.tar.gz"
DIR="${P}"
PREFIX="${MYPARENT}/software/Compiler/${COMPILER}/${PN}/${VER}"
URL="ftp://ftp.gnu.org/gnu/gsl/${FILE}"

BUILDDIR="$(mktemp -d -p "${BUILD_TOP}")"

print_info "${P}" "${BUILDDIR}" "${FILE}" "${URL}" "${DIR}" "${PREFIX}"

cd "${BUILDDIR}"
download_unpack "${URL}" "${FILE}" "${DIR}"
cd "${DIR}"

# Configure
mkdir build; cd build
../configure --prefix="${PREFIX}"

# Build and install
make -j${PARALLEL}
make install

cd "${CURDIR}" 
rm -Rf "${BUILDDIR}"

# Symlink to the module file
mkdir -p "${MYPARENT}/modulefiles/Compiler/${COMPILER}/${PN}"
ln -s "../../../../_generic/${PN}.lua" "${MYPARENT}/modulefiles/Compiler/${COMPILER}/${PN}/${VER}.lua"
