FROM alpine:3.1
MAINTAINER Vladimir Krivosheev <develar@gmail.com>

ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 45
ENV JAVA_VERSION_BUILD 14
ENV JAVA_PACKAGE server-jre

RUN apk add --update curl ca-certificates && \
 cd /tmp && \
 curl -o glibc-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-2.21-r2.apk" && \
 apk add --allow-untrusted glibc-2.21-r2.apk && \
 curl -o glibc-bin-2.21-r2.apk "https://circle-artifacts.com/gh/andyshinn/alpine-pkg-glibc/6/artifacts/0/home/ubuntu/alpine-pkg-glibc/packages/x86_64/glibc-bin-2.21-r2.apk" && \
 apk add --allow-untrusted glibc-bin-2.21-r2.apk && \
 /usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
 curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
  http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz \
    | gunzip -c - | tar -xf - && \
    mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /jdk && \
    rm -rf /jdk/*src.zip \
           /jdk/lib/missioncontrol \
           /jdk/lib/visualvm \
           /jdk/lib/*javafx* \
           /jdk/jre/lib/plugin.jar \
           /jdk/jre/lib/ext/jfxrt.jar \
           /jdk/jre/bin/javaws \
           /jdk/jre/lib/javaws.jar \
           /jdk/jre/lib/desktop \
           /jdk/jre/plugin \
           /jdk/jre/lib/deploy* \
           /jdk/jre/lib/*javafx* \
           /jdk/jre/lib/*jfx* \
           /jdk/jre/lib/amd64/libdecora_sse.so \
           /jdk/jre/lib/amd64/libprism_*.so \
           /jdk/jre/lib/amd64/libfxplugins.so \
           /jdk/jre/lib/amd64/libglass.so \
           /jdk/jre/lib/amd64/libgstreamer-lite.so \
           /jdk/jre/lib/amd64/libjavafx*.so \
           /jdk/jre/lib/amd64/libjfx*.so \
  apk del curl ca-certificates && \
  rm /tmp/* /var/cache/apk/*

ENV JAVA_HOME /jdk
ENV PATH ${PATH}:${JAVA_HOME}/bin

ENTRYPOINT ["java", "-server", "-Djava.security.egd=file:/dev/urandom"]