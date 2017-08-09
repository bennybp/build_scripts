#!/bin/bash

set -eu

CURDIR="$(pwd)"
MYDIR="$(cd "$(dirname "$0")" && pwd)"
source "${MYDIR}/common.sh"

check_args $@

PN="cmake"
VER="$1"

P="${PN}-${VER}"
FILE="${P}.tar.gz"
DIR="${P}"
PREFIX="${MYDIR}/${PN}/${P}"
URL="https://cmake.org/files/v${VER%.*}/${FILE}"

BUILDDIR=$(mktemp -d -p "${BUILD_TOP}")

print_info "${P}" "${BUILDDIR}" "${FILE}" "${URL}" "${DIR}" "${PREFIX}"

cd ${BUILDDIR}
download_unpack "${URL}" "${FILE}" "${DIR}"
cd ${DIR}

# Configure
mkdir build; cd build
../configure --prefix=${PREFIX}

# Build and install
make -j${PARALLEL}
make install

cd "${CURDIR}" 
rm -Rf "${BUILDDIR}"
