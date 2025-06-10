# Build
FROM maven:3.9.6-eclipse-temurin-21-alpine AS build

# -p to avoid dublications
RUN mkdir -p /app
WORKDIR /app

COPY pom.xml /app
COPY src /app/src

# -B to run in batch mode without user interaction
RUN mvn -B package --file pom.xml -DskipTests

# Run
FROM eclipse-temurin:21-jdk-alpine
EXPOSE 8080
COPY --from=build /app/target/*jar cicd-example-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java","-jar","cicd-example-0.0.1-SNAPSHOT.jar"]

# Build the Docker image
# docker build -t devops-demo-app .

# Run the Docker container
# docker run -p 8080:8080 devops-demo-app
