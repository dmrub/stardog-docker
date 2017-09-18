FROM java:8-jre-alpine

ENV STARDOG_VERSION 5.0.3

ENV STARDOG_HOME /data
ENV STARDOG_INSTALL_DIR /opt/stardog

ENV STARDOG_JAVA_ARGS "-Xms2g -Xmx2g -XX:MaxDirectMemorySize=2g"

RUN mkdir -p "${STARDOG_INSTALL_DIR}"

WORKDIR "${STARDOG_INSTALL_DIR}"

RUN apk add --no-cache unzip bash tini

COPY stardog-*.zip /tmp
RUN unzip -d /tmp /tmp/stardog-*.zip && \
    rm -f /tmp/stardog-*.zip && \
    cp -ra /tmp/stardog-*/* "${STARDOG_INSTALL_DIR}"/ && \
    rm -rf /tmp/stardog-*

COPY stardog-license-key.bin \
     stardog.properties \
     "${STARDOG_INSTALL_DIR}"/

COPY docker-entrypoint.sh /usr/local/bin

EXPOSE 5820

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["stardog-admin", "server", "start", "--foreground"]
