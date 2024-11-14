FROM maven:3-openjdk:17 as builder
LABEL authors="Dani"

WORKDIR /build

COPY . .

RUN mvn clean package -DSskipTests -Dcheckstyle.skip=true

FROM openjdk:17-slim

WORKDIR /app

COPY --from=builder /build/target/*.jar /app/app.jar

CMD ["java", "-jar", "app.jar"]
