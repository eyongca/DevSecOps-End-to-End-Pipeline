FROM openjdk:11
COPY target/your-app.jar /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
