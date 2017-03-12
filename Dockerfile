FROM openjdk:8-jdk
MAINTAINER Leifur Halldor Asgeirsson
EXPOSE 8182

ENV GREMLIN_VERSION=3.2.4

WORKDIR /build

RUN apt-get update
RUN apt-get install -y python-setuptools

COPY apache-tinkerpop-gremlin-server-${GREMLIN_VERSION}-bin.zip /build/

RUN unzip -d /opt /build/apache-tinkerpop-gremlin-server-${GREMLIN_VERSION}-bin.zip
RUN ln -s /opt/apache-tinkerpop-gremlin-server-${GREMLIN_VERSION} /opt/gremlin-server

WORKDIR /opt/gremlin-server
COPY gremlin-server.yaml conf/
RUN ./bin/gremlin-server.sh -i org.apache.tinkerpop gremlin-python ${GREMLIN_VERSION}

CMD ./bin/gremlin-server.sh ./conf/gremlin-server.yaml

