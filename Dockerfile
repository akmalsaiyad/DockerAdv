#FROM openjdk:17
#EXPOSE 8080
#ADD target/spring-boot-docker-adv.jar spring-boot-docker-adv.jar 
#ENTRYPOINT ["java","-jar","/spring-boot-docker-adv.jar"]

# Build Stage
FROM maven:3.8-openjdk-17-slim AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Runtime Stage
FROM openjdk:17-slim
COPY --from=builder /app/target/spring-boot-docker-adv.jar spring-boot-docker-adv.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/spring-boot-docker-adv.jar"]
