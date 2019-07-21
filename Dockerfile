FROM openjdk:8-jre

ARG SERVER_VERSION=1.14.4

RUN apt update && apt install -y jq

ADD start.sh setup-vanilla.sh /
ENTRYPOINT [ "/start.sh" ]
ENV SERVER_VERSION=${SERVER_VERSION}
WORKDIR /data
VOLUME /data
EXPOSE 25565/tcp 25565/udp 25575/tcp
LABEL maintainer="ktlo@handtruth.com"
