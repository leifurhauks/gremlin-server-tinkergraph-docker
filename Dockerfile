FROM openjdk:8-jdk
MAINTAINER Leifur Halldor Asgeirsson
EXPOSE 8182

WORKDIR /build

RUN apt-get update
RUN apt-get install -y python-setuptools

COPY apache-tinkerpop-gremlin-server-3.2.4-bin.zip /build/

RUN unzip -d /opt /build/apache-tinkerpop-gremlin-server-3.2.4-bin.zip
RUN ln -s /opt/apache-tinkerpop-gremlin-server-3.2.4 /opt/gremlin-server

WORKDIR /opt/gremlin-server
COPY gremlin-server.yaml conf/
RUN ./bin/gremlin-server.sh -i org.apache.tinkerpop gremlin-python 3.2.4

CMD ./bin/gremlin-server.sh ./conf/gremlin-server.yaml

