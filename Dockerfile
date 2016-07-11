FROM maven:3-jdk-8
MAINTAINER ZEROFAIL
WORKDIR /build

RUN apt-get update
RUN apt-get install -y python-setuptools

COPY tinkerpop /build/tinkerpop/

RUN cd tinkerpop && mvn clean package -DskipTests

RUN unzip -d /opt /build/tinkerpop/gremlin-server/target/apache-gremlin-server-3.2.1-SNAPSHOT-distribution.zip
RUN ln -s /opt/apache-gremlin-server-3.2.1-SNAPSHOT /opt/gremlin-server

EXPOSE 8182

CMD /opt/gremlin-server/bin/gremlin-server.sh /opt/gremlin-server/conf/gremlin-server.yaml

