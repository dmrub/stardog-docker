#!/bin/bash

rm -f ${STARDOG_HOME}/*.lock
rm -f ${STARDOG_HOME}/*.log

${STARDOG_HOME}/bin/stardog-admin server start ${STARDOG_START_PARAMS}
${STARDOG_HOME}/bin/stardog-admin db create ${STARDOG_CREATE_PARAMS}

echo stardog started with the following environment:
echo STARDOG_START_PARAMS: ${STARDOG_START_PARAMS}
echo STARDOG_CREATE_PARAMS: ${STARDOG_CREATE_PARAMS}

/usr/bin/yes > /dev/null