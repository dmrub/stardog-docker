#!/bin/bash

set -e

mkdir -p "${STARDOG_HOME}"
rm -f "${STARDOG_HOME}"/*.lock
rm -f "${STARDOG_HOME}"/*.log

# copy license from install dir if not already in STARDOG_HOME
if [[ ! -f "${STARDOG_HOME}/stardog-license-key.bin" ]]; then
    cp "${STARDOG_INSTALL_DIR}/stardog-license-key.bin" \
       "${STARDOG_HOME}/stardog-license-key.bin"
fi

# copy server properties from install dir if not already in STARDOG_HOME
if [[ ! -f "${STARDOG_HOME}/stardog.properties" ]]; then
    cp "${STARDOG_INSTALL_DIR}/stardog.properties" \
       "${STARDOG_HOME}/stardog.properties"
fi

export PATH=${STARDOG_INSTALL_DIR}/bin:$PATH

cd "${STARDOG_HOME}"

if [[ "$1" == stardog* ]]; then
    # stardog specific handling
    set -x
    exec /sbin/tini -- "$@"
fi

set -x
exec "$@"
