FROM ubuntu:latest AS checkout
RUN apt update && apt install git -y && apt-get clean
RUN git clone https://github.com/Sept-2024/java-example.git
WORKDIR /java-example

FROM maven:amazoncorretto AS build
WORKDIR /app
COPY --from=checkout /java-example /app
RUN mvn clean package
CMD ["bash"]

FROM artisantek/tomcat:1
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 9050
