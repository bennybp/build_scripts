#!/bin/bash

# The MYDIR variable should be set already
if [[ ! -v MYDIR ]]
then
    echo "MYDIR is not set"
    return 1
fi

source "${MYDIR}/options.sh"


download_unpack()
{
    URL="$1"
    FILE="$2"
    DIR="$3"

    echo "URL:  ${URL}"
    echo "FILE: ${FILE}"
    echo "DIR:  ${DIR}"

    # Download the file only if it doesn't exist
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
}


check_args()
{
    if [[ $# > 1 ]]
    then
        echo "Too many arguments passed to script. The only argument should be the version"
        exit 1
    fi
    if [[ $# < 1 ]]
    then
        echo "Script is missing the version argument"
        exit 1
    fi
}


print_info()
{
    echo "---------------------------------------------------------------------"
    echo "   Building package:   ${1}"
    echo "   Building directory: ${2}"
    echo "        Downloading:   ${3}"
    echo "   Downloading from:   ${4}"
    echo "      Extracting to:   ${5}"
    echo "Installation prefix:   ${6}"
    echo "---------------------------------------------------------------------"
}
