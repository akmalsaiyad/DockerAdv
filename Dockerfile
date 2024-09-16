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

# Create a non-root user and group
RUN groupadd -r appgroup && useradd -r -s /bin/bash -g appgroup appuser

# Create a directory for the app and change ownership to the non-root user
WORKDIR /app
COPY --from=builder /app/target/spring-boot-docker-adv.jar spring-boot-docker-adv.jar
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose port 8080 and run the application
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/spring-boot-docker-adv.jar"]

