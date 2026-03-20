# ===== Stage 1: Build =====
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app

# copy source
COPY backend ./backend

# build đúng thư mục
WORKDIR /app/backend
RUN mvn clean package -DskipTests

# ===== Stage 2: Run =====
FROM eclipse-temurin:17-jdk

WORKDIR /app

# copy jar từ stage build
COPY --from=build /app/backend/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]