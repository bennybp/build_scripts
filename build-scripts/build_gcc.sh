#!/bin/bash

set -eu

if [[ $# != 1 ]]
then
  echo "Missing version argument"
  exit 1
fi

VER="$1"
PN="gcc"
P="${PN}-${VER}"
FILE="${P}.tar.gz"
DIR="${P}"
PREFIX="/opt/software/${PN}/${P}"
URL="http://mirrors-usa.go-parts.com/gcc/releases/${P}/${FILE}"

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

# Download the prerequisites
bash contrib/download_prerequisites

# Configure
mkdir build; cd build
../configure --prefix=${PREFIX} \
             --disable-multilib \
             --enable-languages=c,c++,fortran

# Build and install
make -j4
make install

cd ../../
rm -Rf ${DIR}
rm ${FILE}
