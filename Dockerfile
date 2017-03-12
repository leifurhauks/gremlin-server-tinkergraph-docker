FROM openjdk:8-jdk
MAINTAINER Leifur Halldor Asgeirsson
EXPOSE 8182

WORKDIR /build

RUN apt-get update
RUN apt-get install -y python-setuptools

COPY tinkerpop /build/tinkerpop/

RUN unzip -d /opt /build/tinkerpop/apache-tinkerpop-gremlin-server-3.2.4-bin.zip
RUN ln -s /opt/apache-tinkerpop-gremlin-server-3.2.4 /opt/gremlin-server

WORKDIR /opt/gremlin-server
COPY gremlin-server.yaml conf/

CMD ./bin/gremlin-server.sh ./conf/gremlin-server.yaml

