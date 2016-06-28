FROM java:8-jre-alpine

ENV STARDOG_VERSION 4.1.1

ENV STARDOG_HOME /data/stardog
ENV STARDOG_START_PARAMS ""
ENV STARDOG_CREATE_PARAMS "-n stardog -v -o versioning.enabled=true preserve.bnode.ids=false strict.parsing=false --"
ENV STARDOG_JAVA_ARGS "-Xms2g -Xmx2g -XX:MaxDirectMemorySize=2g"
ENV PATH ${STARDOG_HOME}/bin:${PATH}

RUN mkdir -p ${STARDOG_HOME}
WORKDIR ${STARDOG_HOME}

RUN apk update
RUN apk add unzip bash

ADD stardog-*.zip /tmp
RUN unzip -d /tmp /tmp/stardog-*.zip
RUN rm -f /tmp/stardog-*.zip
RUN cp -r /tmp/stardog-*/* /data/stardog/
RUN rm -rf /tmp/stardog-*

ADD stardog-license-key.bin ${STARDOG_HOME}
ADD stardog.properties ${STARDOG_HOME}
ADD start-stardog.sh ${STARDOG_HOME}

CMD ${STARDOG_HOME}/start-stardog.sh

EXPOSE 5820