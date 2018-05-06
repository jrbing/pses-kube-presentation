#
# To build:
#   docker build -t ps-elasticsearch-demo .
#
# To run:
#   docker run --rm ps-elasticsearch-demo

FROM oraclelinux:7-slim

LABEL maintainer="JR Bing <jr@jrbing.com>" \
      base.image="oraclelinux:7-slim" \
      version="1.0"

# Set environment variables
ENV ES_VERSION="2.3.2" \
    ES_JAVA_OPTS="-Xms512m -Xmx512m" \
    JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=0 \
    JAVA_VERSION_BUILD=144 \
    JAVA_HOME=/opt/jre \
    LANG="en_US.utf8"

# Set derived environment variables
ENV ES_ARCHIVE_FILE="pt-elasticsearch${ES_VERSION}.tgz" \
    JAVA_ARCHIVE_FILE="pt-jre1.${JAVA_VERSION_MAJOR}.${JAVA_VERSION_MINOR}_${JAVA_VERSION_BUILD}.tgz" \
    JCE_ARCHIVE_FILE="jce_policy-${JAVA_VERSION_MAJOR}.zip" \
    PATH="${PATH}:/elasticsearch/bin:/opt/jre/bin"

# Define the volume to be used for Elasticsearch data
VOLUME ["/data"]

# Expose the http and node transport ports
EXPOSE 9200 9300

# Install prerequisites, cleanup yum artifacts, and update nsswitch.conf
RUN set -ex \
    && yum update -y \
    && yum install -y \
    sudo \
    ca-certificates \
    sudo \
    curl \
    wget \
    which \
    unzip \
    tar \
    util-linux \
    hostname \
    && yum clean all \
    && rm -rf /var/cache/yum

# Copy and unpack java archive
ADD ${JAVA_ARCHIVE_FILE} /opt/jre

# Download and install the unlimited jce policy from Oracle, update the java
# networkaddress.cache.ttl setting so that successfull lookups correctly expire
# after 10 seconds, and cleanup unnecessary java binaries & libraries.
RUN set -ex \
    && curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
      http://download.oracle.com/otn-pub/java/jce/${JAVA_VERSION_MAJOR}/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cd /tmp \
    && unzip /tmp/jce_policy-${JAVA_VERSION_MAJOR}.zip \
    && cp -v /tmp/UnlimitedJCEPolicyJDK8/*.jar /opt/jre/lib/security/ \
    && sed -i 's/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=10/' ${JAVA_HOME}/lib/security/java.security \
    && rm -rf /opt/jre/plugin \
           /opt/jre/bin/javaws \
           /opt/jre/bin/jjs \
           /opt/jre/bin/orbd \
           /opt/jre/bin/pack200 \
           /opt/jre/bin/policytool \
           /opt/jre/bin/rmid \
           /opt/jre/bin/rmiregistry \
           /opt/jre/bin/servertool \
           /opt/jre/bin/tnameserv \
           /opt/jre/bin/unpack200 \
           /opt/jre/lib/javaws.jar \
           /opt/jre/lib/deploy* \
           /opt/jre/lib/desktop \
           /opt/jre/lib/*javafx* \
           /opt/jre/lib/*jfx* \
           /opt/jre/lib/amd64/libdecora_sse.so \
           /opt/jre/lib/amd64/libprism_*.so \
           /opt/jre/lib/amd64/libfxplugins.so \
           /opt/jre/lib/amd64/libglass.so \
           /opt/jre/lib/amd64/libgstreamer-lite.so \
           /opt/jre/lib/amd64/libjavafx*.so \
           /opt/jre/lib/amd64/libjfx*.so \
           /opt/jre/lib/ext/jfxrt.jar \
           /opt/jre/lib/ext/nashorn.jar \
           /opt/jre/lib/oblique-fonts \
           /opt/jre/lib/plugin.jar \
           /tmp/*

# Create the Elasticsearch user and group
RUN set -ex \
    && mkdir /elasticsearch \
    && groupadd -g 1000 elasticsearch \
    && adduser -u 1000 -g 1000 -d /elasticsearch elasticsearch

# Copy and unpack the Elasticsearch archive
ADD --chown=1000:1000 ${ES_ARCHIVE_FILE} /elasticsearch

# Set ownership on Elasticsearch files & data, set executable bit
# on Elasticsearch binaries, and install additional Elasticsearch
# plugins.
RUN set -ex \
    && chown -R elasticsearch:elasticsearch /elasticsearch \
    && chown -R elasticsearch:elasticsearch /data \
    && chmod +x /elasticsearch/bin/elasticsearch \
    && chmod +x /elasticsearch/bin/elasticsearchuser \
    && chmod +x /elasticsearch/bin/plugin \
    && /elasticsearch/bin/plugin install cloud-azure --verbose \
    && /elasticsearch/bin/plugin install io.fabric8/elasticsearch-cloud-kubernetes/${ES_VERSION} --verbose

# Set the current working directory
WORKDIR /elasticsearch

# Copy the Elasticsearch configuration files
COPY --chown=1000:1000 config /elasticsearch/config

# Copy the script to start the Elasticsearch instance
COPY run.sh /

# By default, run the Elasticsearch startup script
CMD ["/bin/bash", "-c", "/run.sh"]
