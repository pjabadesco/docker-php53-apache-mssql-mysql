docker-compose build

docker build -t pjabadesco/php53-apache-mssql-mysql:1.0 .
docker push pjabadesco/php53-apache-mssql-mysql:1.0

docker build -t pjabadesco/php53-apache-mssql-mysql:latest .
docker push pjabadesco/php53-apache-mssql-mysql:latest
