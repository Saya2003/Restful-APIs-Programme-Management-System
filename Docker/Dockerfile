FROM ballerina/ballerina:latest

WORKDIR /app
COPY . .

# Install MySQL client if needed
RUN apt-get update && apt-get install -y default-libmysqlclient-dev
RUN ballerina build services/logistics

CMD ["ballerina", "run", "services/logistics/target/bin/logistics.jar"]
