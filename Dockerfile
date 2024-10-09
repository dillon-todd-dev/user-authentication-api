# build step
FROM gradle:8.10.2-jdk21 AS build

COPY --chown=gradle:gradle . /home/gradle/src

WORKDIR /home/gradle/src

RUN gradle :bootjar --no-daemon

FROM openjdk:21-jdk-slim

WORKDIR /app

COPY --from=build /home/gradle/src/build/libs/*.jar application.jar

EXPOSE 8000

ENTRYPOINT [ "java", "-jar", "application.jar" ]