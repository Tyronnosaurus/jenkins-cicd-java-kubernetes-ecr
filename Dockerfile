# Start from a Maven image for building Java applications
FROM maven:3.9.4-eclipse-temurin-17-alpine as builder

# Set the working directory inside the container
WORKDIR /usr/app

# Copy the Maven project files (pom.xml and source code)
COPY ./app /usr/app

# Build the Java application using Maven
RUN mvn clean package


# Use a lightweight OpenJDK image to run the application
FROM openjdk:8-jre-alpine

# Set the working directory inside the container
WORKDIR /usr/app

# Copy the built JAR file from the builder stage
COPY --from=builder /usr/app/target/*.jar app.jar

# Set the command to run the Java application
CMD ["java", "-jar", "app.jar"]