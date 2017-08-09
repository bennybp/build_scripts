#!/bin/bash

set -eu

if [[ $# != 1 ]]
then
  echo "Missing version argument"
  exit 1
fi

VER="$1"
VER_MAJOR="${VER:0:1}"
PN="Python"
P="${PN}-${VER}"
FILE="${P}.tgz"
DIR="${P}"
PREFIX="/opt/software/python${VER_MAJOR}/python${VER_MAJOR}-${VER}" # Use lowercase
URL="https://www.python.org/ftp/python/${VER}/${FILE}"

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
../configure --enable-shared \
             --prefix=${PREFIX}

# Build and install
make -j4
make install

cd ../../
rm -Rf ${DIR}
rm ${FILE}


echo "=================================================="
echo " If you just built python2, you need to load the"
echo " module and run the following to install pip:"
echo "     python2 -m ensurepip"
echo "=================================================="
