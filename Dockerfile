FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

COPY target/my-app-1.0.jar app.jar

CMD ["java", "-jar", "app.jar"]

