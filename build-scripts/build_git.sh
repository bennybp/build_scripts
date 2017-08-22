#!/bin/bash

set -eu

CURDIR="$(pwd)"
MYDIR="$(cd "$(dirname "$0")" && pwd)"
MYPARENT="$(dirname "${MYDIR}")"

source "${MYDIR}/common.sh"

check_args $@

PN="git"
VER="$1"

P="${PN}-${VER}"
FILE="${P}.tar.gz"
DIR="${P}"
PREFIX="${MYPARENT}/software/Core/${PN}/${VER}"
URL="https://www.kernel.org/pub/software/scm/git/${FILE}"

BUILDDIR="$(mktemp -d -p "${BUILD_TOP}")"

print_info "${P}" "${BUILDDIR}" "${FILE}" "${URL}" "${DIR}" "${PREFIX}"

cd "${BUILDDIR}"
download_unpack "${URL}" "${FILE}" "${DIR}"
cd "${DIR}"

# Configure
./configure --prefix="${PREFIX}"

# Build and install
make -j${PARALLEL}
make install

cd "${CURDIR}" 
rm -Rf "${BUILDDIR}"

# Symlink to the module file
mkdir -p "${MYPARENT}/modulefiles/Core/${PN}"
ln -s "../../_generic/${PN}.lua" "${MYPARENT}/modulefiles/Core/${PN}/${VER}.lua"
