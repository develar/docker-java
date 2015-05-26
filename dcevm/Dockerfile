FROM develar/java:8u45
MAINTAINER Vladimir Krivosheev <develar@gmail.com>

COPY libjvm.so /jre/lib/amd64/server/libjvm.so

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/urandom"]