#!/bin/bash

set -eu

CURDIR="$(pwd)"
MYDIR="$(cd "$(dirname "$0")" && pwd)"
MYPARENT="$(dirname "${MYDIR}")"

source "${MYDIR}/common.sh"

check_args $@

VER="$1"
VER_MAJOR="${VER:0:1}"
PN="python${VER_MAJOR}" # We name this package python2 or python3

P="${PN}-${VER}"
FILE="Python-${VER}.tgz"
DIR="Python-${VER}"
PREFIX="${MYPARENT}/software/Core/${PN}/${VER}"
URL="https://www.python.org/ftp/python/${VER}/${FILE}"

BUILDDIR="$(mktemp -d -p "${BUILD_TOP}")"

print_info "${P}" "${BUILDDIR}" "${FILE}" "${URL}" "${DIR}" "${PREFIX}"

cd "${BUILDDIR}"
download_unpack "${URL}" "${FILE}" "${DIR}"
cd "${DIR}"

# Configure
mkdir build; cd build
../configure --enable-shared \
             --prefix=${PREFIX}

# Build and install
make -j${PARALLEL}
make install

cd "${CURDIR}" 
rm -Rf "${BUILDDIR}"

# Symlink to the module file
mkdir -p "${MYPARENT}/modulefiles/Core/${PN}"
ln -s "../../_generic/${PN}.lua" "${MYPARENT}/modulefiles/Core/${PN}/${VER}.lua"

echo "=================================================="
echo " If you just built python2, you need to load the"
echo " module and run the following to install pip:"
echo "     python2 -m ensurepip"
echo "=================================================="
