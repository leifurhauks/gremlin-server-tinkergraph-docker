FROM maven:3-jdk-8
MAINTAINER ZEROFAIL
EXPOSE 8182

WORKDIR /build

RUN apt-get update
RUN apt-get install -y python-setuptools

COPY tinkerpop /build/tinkerpop/

WORKDIR tinkerpop
RUN mvn clean package -DskipTests

RUN unzip -d /opt /build/tinkerpop/gremlin-server/target/apache-gremlin-server-3.2.1-SNAPSHOT-distribution.zip
RUN ln -s /opt/apache-gremlin-server-3.2.1-SNAPSHOT /opt/gremlin-server

WORKDIR /opt/gremlin-server
COPY gremlin-server.yaml conf/

CMD ./bin/gremlin-server.sh ./conf/gremlin-server.yaml

