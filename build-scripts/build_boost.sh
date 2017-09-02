#!/bin/bash

set -eu

CURDIR="$(pwd)"
MYDIR="$(cd "$(dirname "$0")" && pwd)"
MYPARENT="$(dirname "${MYDIR}")"

source "${MYDIR}/common.sh"

check_args $@

PN="boost"
VER="$1"
COMPILER="gcc/$(gcc --version | head -n 1 | awk '{print $NF}')"

module load "${COMPILER}"

P="${PN}-${VER}"
P2="${P//./_}"
P2="${P2//-/_}"
FILE="${P2}.tar.bz2"
DIR="${P2}"
PREFIX="${MYPARENT}/software/Compiler/${COMPILER}/${PN}/${VER}"
URL="http://dl.bintray.com/boostorg/release/${VER}/source/${FILE}"

# We don't use /tmp since this needs quite a bit of space
BUILDDIR="$(mktemp -d -p .)"

print_info "${P}" "${BUILDDIR}" "${FILE}" "${URL}" "${DIR}" "${PREFIX}"

cd "${BUILDDIR}"
download_unpack "${URL}" "${FILE}" "${DIR}"
cd "${DIR}"

# Bootstrap and build
./bootstrap.sh
./b2 --without-python --build-type=minimal --prefix=${PREFIX} -j${PARALLEL} stage install

cd "${CURDIR}" 
rm -Rf "${BUILDDIR}"

# Symlink to the module file
mkdir -p "${MYPARENT}/modulefiles/Compiler/${COMPILER}/${PN}"
ln -s "../../../../_generic/${PN}.lua" "${MYPARENT}/modulefiles/Compiler/${COMPILER}/${PN}/${VER}.lua"
