#!/bin/bash

set -eu

if [[ $# != 1 ]]
then
  echo "Missing version argument"
  exit 1
fi

VER="$1"
PN="valgrind"
P="${PN}-${VER}"
FILE="${P}.tar.bz2"
DIR="${P}"
PREFIX="/opt/software/${PN}/${P}"
URL="ftp://sourceware.org/pub/valgrind/${FILE}"

mkdir -p /tmp/bpp4build
cd /tmp/bpp4build

# Download the file
if [[ ! -f "${FILE}" ]]
then
    wget -O "${FILE}" "${URL}"
else
    echo "Using already-downloaded file: ${FILE}"
fi

# Unpack the tarball and change to the directory
if [[ ! -d "${DIR}" ]]
then
    tar -xvf "${FILE}"
else
    echo "Using already unpacked directory ${DIR}"
fi

cd ${DIR}

# Configure
mkdir build; cd build
../configure --prefix=${PREFIX}

# Build and install
make -j4
make install

cd ../../
rm -Rf ${DIR}
rm ${FILE}
