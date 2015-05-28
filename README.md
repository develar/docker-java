## Minimal Docker image with Java

[Docker](https://www.docker.com/) image to run [Java](https://www.java.com/) applications.
This is based off [Alpine](https://registry.hub.docker.com/_/alpine/) to keep the size minimal (117 MB).

Consider to use develar/java:8u45-dcevm during development — [DCEVM](http://dcevm.github.io).

Docker compose example to run application from classes:

```yaml
image: develar/java:8u45
environment:
  _JAVA_OPTIONS: "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5050 -Xms48m -Xmx64M"
  CLASSPATH: /app/lib/*:/app/classes
volumes:
  - out/production/moduleName:/app/classes:ro
  - lib:/app/lib:ro
command: com.example.ClassName
expose:
 - "80"
ports:
  - "5050:5050"
```
